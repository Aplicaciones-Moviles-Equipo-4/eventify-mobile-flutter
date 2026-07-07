import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';
import '../../../data/datasources/remote/auth_service.dart';
import '../../../data/datasources/remote/api_client.dart';
import '../../../data/models/auth/user_model.dart';

// Provider for the remote authentication service (AuthService).
// Depends on dioProvider to perform network requests.
final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthService(dio);
});

// Provider for secure storage to persist the JWT token locally and securely.
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// Main provider for the application's authentication state (AuthNotifier).
// Exposes AuthState and triggers login, registration, logout, and session validation actions.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final storage = ref.watch(secureStorageProvider);
  return AuthNotifier(authService, storage);
});

// Derived provider (read-only) that directly checks if the user is authenticated.
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );
});

// Derived provider (read-only) that retrieves the current user if the session is active.
final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    authenticated: (user) => user,
    orElse: () => null,
  );
});
