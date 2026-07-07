import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/env.dart';
import 'interceptors.dart';

// Global provider for the Dio HTTP client instance.
// Configures base options like timeouts, base URL, and registers common interceptors.
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.baseUrl,
      connectTimeout: Env.connectTimeout,
      receiveTimeout: Env.receiveTimeout,
      contentType: 'application/json',
    ),
  );

  // Auth interceptor is added to automatically append JWT tokens.
  dio.interceptors.add(AuthInterceptor(ref));
  
  // Logging interceptor is added to debug HTTP requests during development.
  dio.interceptors.add(LoggingInterceptor());

  return dio;
});
