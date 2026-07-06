import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Ejecutamos la inicialización después del primer frame para evitar conflictos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    // Esperamos 2 segundos
    await Future.delayed(const Duration(seconds: 2));
    
    // Si el widget se cerró durante la espera, no hacemos nada
    if (!mounted) return;

    try {
      // Verificamos la sesión
      await ref.read(authProvider.notifier).checkAuthStatus();
    } catch (e) {
      debugPrint('Error en Splash: $e');
    } finally {
      // Navegación final segura
      if (mounted) {
        final authState = ref.read(authProvider);
        final isAuthenticated = authState.maybeWhen(
          authenticated: (_) => true, 
          orElse: () => false
        );

        if (isAuthenticated) {
          context.go('/dashboard');
        } else {
          context.go('/login');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            SizedBox(height: 24),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
