import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Interceptor responsible for injecting the authentication JWT token into request headers
// and clearing the saved token in case of a 401 (unauthorized) response.
class AuthInterceptor extends QueuedInterceptor {
  final Ref ref;
  
  AuthInterceptor(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    const storage = FlutterSecureStorage();
    // Attempts to read the stored token securely
    final token = await storage.read(key: 'auth_token');
    
    // If the token exists, inject it into the Authorization header
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // If the server responds with 401 Unauthorized, delete the local token
    if (err.response?.statusCode == 401) {
      const storage = FlutterSecureStorage();
      storage.delete(key: 'auth_token');
      // Redirect to login page is handled reactively by the Router/AuthProvider
    }
    handler.next(err);
  }
}

// Diagnostic interceptor to print HTTP requests and responses to the console.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('➡️  ${options.method} ${options.path}');
    print('   Headers: ${options.headers}');
    print('   Data: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('⬅️  ${response.statusCode} ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ Error: ${err.response?.statusCode} - ${err.message}');
    handler.next(err);
  }
}
