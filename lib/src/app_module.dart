import 'package:flutter_modular/flutter_modular.dart';

import 'modules/base/base_layout.dart';
import 'modules/core/core_module.dart';
import 'modules/login/login_module.dart';
import 'modules/payment_type/payment_type_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute<BaseLayout>(
          '/',
          children: [ModuleRoute('/payment-type', module: PaymentTypeModule())],
          child: (_, __) => const BaseLayout(body: RouterOutlet()),
        ),
        ModuleRoute<LoginModule>('/login', module: LoginModule()),
      ];

  @override
  List<Module> get imports => [CoreModule()];
}
