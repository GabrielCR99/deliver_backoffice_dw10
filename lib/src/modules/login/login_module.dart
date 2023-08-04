import 'package:flutter_modular/flutter_modular.dart';

import '../../repositories/auth/auth_repository.dart';
import '../../repositories/auth/auth_repository_impl.dart';
import '../../services/auth/login_service.dart';
import '../../services/auth/login_service_impl.dart';
import 'login_controller.dart';
import 'login_page.dart';

final class LoginModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i
      ..addLazySingleton<AuthRepository>(AuthRepositoryImpl.new)
      ..addSingleton<LoginService>(LoginServiceImpl.new)
      ..addLazySingleton<LoginController>(LoginController.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child('/', child: (_) => const LoginPage());
  }
}
