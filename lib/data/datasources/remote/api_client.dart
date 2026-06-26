import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/env.dart';
import 'interceptors.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.baseUrl,
      connectTimeout: Env.connectTimeout,
      receiveTimeout: Env.receiveTimeout,
      contentType: 'application/json',
    ),
  );

  dio.interceptors.add(AuthInterceptor(ref));
  dio.interceptors.add(LoggingInterceptor());

  return dio;
});
