import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/user_model.dart';
import 'user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  final CustomDio _dio;

  const UserRepositoryImpl(this._dio);

  @override
  Future<UserModel> findById(int id) async {
    try {
      final Response(:data) =
          await _dio.get<Map<String, dynamic>>('/users/$id');

      return UserModel.fromMap(data!);
    } catch (e, s) {
      log('Erro ao buscar usuário', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(message: 'Erro ao buscar usuário'),
        s,
      );
    }
  }
}
