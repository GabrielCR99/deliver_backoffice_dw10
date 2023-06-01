import 'package:flutter/material.dart';

import '../../core/global/constants.dart';
import '../../core/storage/storage.dart';
import '../../repositories/auth/auth_repository.dart';
import 'login_service.dart';

@immutable
final class LoginServiceImpl implements LoginService {
  final AuthRepository _authRepository;
  final Storage _storage;

  const LoginServiceImpl({
    required AuthRepository authRepository,
    required Storage storage,
  })  : _authRepository = authRepository,
        _storage = storage;

  @override
  Future<void> execute({
    required String email,
    required String password,
  }) async {
    final accessToken = await _authRepository.login(
      email: email,
      password: password,
    );

    return _storage.setData(
      key: SessionStorageKeys.accessToken.key,
      value: accessToken,
    );
  }
}
