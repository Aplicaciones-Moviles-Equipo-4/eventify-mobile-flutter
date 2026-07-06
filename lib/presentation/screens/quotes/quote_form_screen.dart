import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../providers/quotes/quotes_provider.dart';
import '../../providers/quotes/quote_form_state.dart';
import '../../providers/auth/auth_provider.dart';

class QuoteFormScreen extends ConsumerStatefulWidget {
  final int organizerId;

  const QuoteFormScreen({Key? key, required this.organizerId}) : super(key: key);

  @override
  ConsumerState<QuoteFormScreen> createState() => _QuoteFormScreenState();
}

class _QuoteFormScreenState extends ConsumerState<QuoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) {
      ref.read(quoteFormProvider(widget.organizerId).notifier).updateEventDate(picked);
      _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(quoteFormProvider(widget.organizerId));
    final formNotifier = ref.read(quoteFormProvider(widget.organizerId).notifier);
    final user = ref.watch(currentUserProvider);

    ref.listen(quoteFormProvider(widget.organizerId), (previous, next) {
      if (previous?.createdQuote == null && next.createdQuote != null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('¡Cotización Enviada! 🎉'),
            content: const Text('El organizador ha recibido tu solicitud. Te contactará pronto.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go('/dashboard');
                },
                child: const Text('Ir al Dashboard'),
              ),
            ],
          ),
        );
      }
      if (next.errorMessage != null && previous?.errorMessage != next.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Solicitar Cotización')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Título del evento', border: OutlineInputBorder()),
                validator: (val) => val == null || val.length < 3 ? 'Debe tener al menos 3 caracteres' : null,
                onChanged: formNotifier.updateTitle,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Tipo de Evento', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'WEDDING', child: Text('Boda (Wedding)')),
                  DropdownMenuItem(value: 'BIRTHDAY', child: Text('Cumpleaños (Birthday)')),
                  DropdownMenuItem(value: 'CORPORATE', child: Text('Corporativo (Corporate)')),
                  DropdownMenuItem(value: 'OTHER', child: Text('Otro')),
                ],
                validator: (val) => val == null || val.isEmpty ? 'Selecciona un tipo' : null,
                onChanged: (val) {
                  if (val != null) formNotifier.updateEventType(val);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Fecha del evento',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ubicación (Ej. Salón principal, Dirección)', border: OutlineInputBorder()),
                validator: (val) => val == null || val.isEmpty ? 'Ubicación requerida' : null,
                onChanged: formNotifier.updateLocation,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Número de invitados:', style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: formState.guestQuantity > 1 
                        ? () => formNotifier.updateGuestQuantity(formState.guestQuantity - 1)
                        : null,
                  ),
                  Text('${formState.guestQuantity}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () => formNotifier.updateGuestQuantity(formState.guestQuantity + 1),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Detalles adicionales (Opcional)',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                onChanged: formNotifier.updateAdditionalDetails,
              ),
              const Divider(height: 48),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Servicios Requeridos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(icon: const Icon(Icons.add, color: Colors.blue), onPressed: formNotifier.addServiceItem),
                ],
              ),
              ...formState.serviceItems.asMap().entries.map((entry) {
                int idx = entry.key;
                ServiceItemForm item = entry.value;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(labelText: 'Descripción del servicio'),
                                validator: (val) => val == null || val.isEmpty ? 'Requerido' : null,
                                onChanged: (val) => formNotifier.updateServiceItem(idx, item.copyWith(description: val)),
                              ),
                            ),
                            if (formState.serviceItems.length > 1)
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => formNotifier.removeServiceItem(idx),
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(labelText: 'Cantidad'),
                                keyboardType: TextInputType.number,
                                validator: (val) => int.tryParse(val ?? '') == null || int.parse(val!) < 1 ? 'Inválido' : null,
                                onChanged: (val) => formNotifier.updateServiceItem(idx, item.copyWith(quantity: int.tryParse(val) ?? 1)),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(labelText: 'Precio Ref. (\$)'),
                                keyboardType: TextInputType.number,
                                validator: (val) => double.tryParse(val ?? '') == null ? 'Inválido' : null,
                                onChanged: (val) => formNotifier.updateServiceItem(idx, item.copyWith(unitPrice: double.tryParse(val) ?? 0)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Presupuesto Total:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('\$${formState.totalBudget.toStringAsFixed(2)}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: formState.isLoading ? null : () {
                    if (_formKey.currentState!.validate() && user != null) {
                      formNotifier.submitQuote(hostId: user.id);
                    }
                  },
                  child: formState.isLoading 
                    ? const CircularProgressIndicator()
                    : const Text('Enviar Cotización', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
