import 'package:flutter_modular/flutter_modular.dart';

import '../../repositories/auth/auth_repository.dart';
import '../../repositories/auth/auth_repository_impl.dart';
import '../../services/auth/login_service.dart';
import '../../services/auth/login_service_impl.dart';
import 'login_controller.dart';
import 'login_page.dart';

final class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<AuthRepository>((i) => AuthRepositoryImpl(dio: i())),
        Bind.lazySingleton<LoginService>(
          (i) => LoginServiceImpl(authRepository: i(), storage: i()),
        ),
        Bind.lazySingleton((i) => LoginController(loginService: i())),
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute<LoginPage>('/', child: (_, __) => const LoginPage())];
}
