import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/profile/profile_provider.dart';
import '../../../data/models/profile/profile_model.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  final ProfileModel? profileToEdit;

  const ProfileSetupScreen({Key? key, this.profileToEdit}) : super(key: key);

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _firstNameCtrl;
  late TextEditingController _lastNameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _streetCtrl;
  late TextEditingController _numberCtrl;
  late TextEditingController _cityCtrl;
  late TextEditingController _postalCodeCtrl;
  late TextEditingController _countryCtrl;
  
  bool _isLoading = false;
  File? _imageFile;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final p = widget.profileToEdit;
    _firstNameCtrl = TextEditingController(text: p?.firstName);
    _lastNameCtrl = TextEditingController(text: p?.lastName);
    _emailCtrl = TextEditingController(text: p?.email);
    _streetCtrl = TextEditingController(text: p?.street);
    _numberCtrl = TextEditingController(text: p?.number);
    _cityCtrl = TextEditingController(text: p?.city);
    _postalCodeCtrl = TextEditingController(text: p?.postalCode);
    _countryCtrl = TextEditingController(text: p?.country);
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _streetCtrl.dispose();
    _numberCtrl.dispose();
    _cityCtrl.dispose();
    _postalCodeCtrl.dispose();
    _countryCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      final service = ref.read(profileServiceProvider);
      
      final data = {
        'firstName': _firstNameCtrl.text,
        'lastName': _lastNameCtrl.text,
        'email': _emailCtrl.text,
        'street': _streetCtrl.text,
        'number': _numberCtrl.text,
        'city': _cityCtrl.text,
        'postalCode': _postalCodeCtrl.text,
        'country': _countryCtrl.text,
        'type': widget.profileToEdit?.type ?? 'HOSTER',
      };

      if (widget.profileToEdit != null) {
        await service.updateProfile(widget.profileToEdit!.id, data);
      } else {
        final profile = await service.createProfile(
          firstName: _firstNameCtrl.text,
          lastName: _lastNameCtrl.text,
          email: _emailCtrl.text,
          street: _streetCtrl.text,
          number: _numberCtrl.text,
          city: _cityCtrl.text,
          postalCode: _postalCodeCtrl.text,
          country: _countryCtrl.text,
        );
        const storage = FlutterSecureStorage();
        await storage.write(key: 'profile_id', value: profile.id.toString());
      }
      
      ref.invalidate(currentProfileProvider);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.profileToEdit != null ? 'Perfil actualizado' : 'Perfil creado exitosamente')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.profileToEdit != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar Perfil' : 'Configurar Perfil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _imageFile != null 
                          ? FileImage(_imageFile!) 
                          : (widget.profileToEdit?.profilePictureUrl != null 
                              ? NetworkImage(widget.profileToEdit!.profilePictureUrl!) 
                              : null) as ImageProvider?,
                      child: _imageFile == null && widget.profileToEdit?.profilePictureUrl == null
                          ? const Icon(Icons.person, size: 60, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 20,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameCtrl,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      validator: (v) => v!.isEmpty ? 'Requerido' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameCtrl,
                      decoration: const InputDecoration(labelText: 'Apellidos'),
                      validator: (v) => v!.isEmpty ? 'Requerido' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email de contacto'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _streetCtrl,
                      decoration: const InputDecoration(labelText: 'Calle / Avenida'),
                      validator: (v) => v!.isEmpty ? 'Requerido' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _numberCtrl,
                      decoration: const InputDecoration(labelText: 'Número'),
                      validator: (v) => v!.isEmpty ? 'Requerido' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cityCtrl,
                      decoration: const InputDecoration(labelText: 'Ciudad'),
                      validator: (v) => v!.isEmpty ? 'Requerido' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _postalCodeCtrl,
                      decoration: const InputDecoration(labelText: 'Cód. Postal'),
                      validator: (v) => v!.isEmpty ? 'Requerido' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _countryCtrl,
                decoration: const InputDecoration(labelText: 'País'),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 40),
              
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading 
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(isEditing ? 'Guardar Cambios' : 'Crear Perfil', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
