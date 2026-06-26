import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<Map<String, dynamic>> signUp(String username, String password) async {
    try {
      final response = await dio.post(
        ApiConstants.signUp,
        data: {
          'username': username,
          'password': password,
          'roles': ['HOST'],
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Sign up failed: \${e.response?.data}');
    }
  }

  Future<Map<String, dynamic>> signIn(String username, String password) async {
    try {
      final response = await dio.post(
        ApiConstants.signIn,
        data: {
          'username': username,
          'password': password,
        },
      );
      return response.data; // { id, username, token }
    } on DioException catch (e) {
      throw Exception('Sign in failed: \${e.response?.data}');
    }
  }
}
