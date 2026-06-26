import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Ref ref;
  
  AuthInterceptor(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      const storage = FlutterSecureStorage();
      storage.delete(key: 'auth_token');
      // Redirigir a login logic would typically be handled by a provider or router
    }
    handler.next(err);
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('➡️  \${options.method} \${options.path}');
    print('   Headers: \${options.headers}');
    print('   Data: \${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('⬅️  \${response.statusCode} \${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ Error: \${err.response?.statusCode} - \${err.message}');
    handler.next(err);
  }
}
