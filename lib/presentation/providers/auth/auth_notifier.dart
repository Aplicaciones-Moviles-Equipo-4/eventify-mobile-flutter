import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_state.dart';
import '../../../data/models/auth/user_model.dart';
import '../../../data/datasources/remote/auth_service.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService authService;
  final FlutterSecureStorage secureStorage;

  AuthNotifier(this.authService, this.secureStorage) 
    : super(const AuthState.initial());

  Future<void> signUp(String username, String password) async {
    state = const AuthState.loading();
    try {
      await authService.signUp(username, password);
      await signIn(username, password);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signIn(String username, String password) async {
    state = const AuthState.loading();
    try {
      final response = await authService.signIn(username, password);
      final user = UserModel.fromJson(response);
      
      if (user.token != null) {
        await secureStorage.write(key: 'auth_token', value: user.token!);
        await secureStorage.write(key: 'user_id', value: user.id.toString());
        await secureStorage.write(key: 'username', value: user.username);
      }

      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'auth_token');
    await secureStorage.delete(key: 'user_id');
    await secureStorage.delete(key: 'username');
    state = const AuthState.unauthenticated();
  }

  Future<void> checkAuthStatus() async {
    state = const AuthState.loading();
    try {
      final token = await secureStorage.read(key: 'auth_token');
      final userId = await secureStorage.read(key: 'user_id');
      final username = await secureStorage.read(key: 'username');
      
      if (token == null || userId == null || username == null) {
        state = const AuthState.unauthenticated();
      } else {
        state = AuthState.authenticated(
          UserModel(
            id: int.parse(userId),
            username: username,
            roles: ['HOST'],
            token: token
          )
        );
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
