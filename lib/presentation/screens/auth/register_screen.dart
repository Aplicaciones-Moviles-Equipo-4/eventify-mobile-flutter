import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth/auth_provider.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final usernameCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();

    ref.listen(authProvider, (previous, next) {
      next.maybeWhen(
        authenticated: (_) => context.go('/dashboard'),
        error: (message) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        ),
        orElse: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Crear Cuenta')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FlutterLogo(size: 80),
              const SizedBox(height: 40),
              TextField(
                controller: usernameCtrl,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar Contraseña',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: authState.maybeWhen(
                    loading: () => null,
                    orElse: () => () {
                      if (passwordCtrl.text != confirmCtrl.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Las contraseñas no coinciden')),
                        );
                        return;
                      }
                      ref.read(authProvider.notifier).signUp(
                        usernameCtrl.text,
                        passwordCtrl.text,
                      );
                    },
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: authState.maybeWhen(
                    loading: () => const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    orElse: () => const Text('Registrarse'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿Ya tienes cuenta? '),
                  GestureDetector(
                    onTap: () => context.go('/login'),
                    child: Text(
                      'Inicia sesión',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
