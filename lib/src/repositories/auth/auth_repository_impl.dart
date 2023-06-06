import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../core/exceptions/repository_exception.dart';
import '../../core/exceptions/unauthorized_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import 'auth_repository.dart';

@immutable
final class AuthRepositoryImpl implements AuthRepository {
  final CustomDio _dio;

  const AuthRepositoryImpl({required CustomDio dio}) : _dio = dio;

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _dio.unauth().post<Map<String, dynamic>>(
        '/auth',
        data: {
          'email': email,
          'password': password,
          'admin': true,
        },
      );

      return result.data?['access_token'] as String;
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 403) {
        log('Usuário ou senha inválidos', error: e, stackTrace: s);

        Error.throwWithStackTrace(UnauthorizedException(), s);
      }

      log('Erro ao realizar login', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(message: 'Erro ao realiar login'),
        s,
      );
    }
  }
}
