import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';
import '../../../data/datasources/remote/auth_service.dart';
import '../../../data/datasources/remote/api_client.dart';
import '../../../data/models/auth/user_model.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthService(dio);
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final storage = ref.watch(secureStorageProvider);
  return AuthNotifier(authService, storage);
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );
});

final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    authenticated: (user) => user,
    orElse: () => null,
  );
});
