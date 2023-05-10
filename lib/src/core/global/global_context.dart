import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../storage/storage.dart';

class GlobalContext {
  static GlobalContext? _instance;
  late final GlobalKey<NavigatorState> _navigatorKey;

  GlobalContext._();
  static GlobalContext get instance {
    _instance ??= GlobalContext._();

    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> navigatorKey) =>
      _navigatorKey = navigatorKey;

  void loginExpired() {
    Modular.get<Storage>().clearData();
    ScaffoldMessenger.of(_navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          title: 'Login expirado',
          message: 'Login expirado, faça o login novamente',
          contentType: ContentType.failure,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: const EdgeInsets.only(top: 72),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Modular.to.navigate('/login/');
  }
}
