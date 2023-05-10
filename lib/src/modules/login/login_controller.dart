import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../core/exceptions/unauthorized_exception.dart';
import '../../services/auth/login_service.dart';
part 'login_controller.g.dart';

enum LoginStateStatus { initial, loading, success, error }

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  @readonly
  var _loginStatus = LoginStateStatus.initial;

  @readonly
  String? _errorMessage;

  final LoginService _loginService;

  LoginControllerBase({required LoginService loginService})
      : _loginService = loginService;

  @action
  Future<void> login({required String email, required String password}) async {
    _loginStatus = LoginStateStatus.loading;

    try {
      await _loginService.execute(email: email, password: password);

      _loginStatus = LoginStateStatus.success;
    } on UnauthorizedException {
      _errorMessage = 'Usuário ou senha inválidos';
      _loginStatus = LoginStateStatus.error;
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);

      _errorMessage = 'Erro ao realizar login';
      _loginStatus = LoginStateStatus.error;
    }
  }
}
