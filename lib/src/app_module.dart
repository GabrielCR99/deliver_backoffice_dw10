import 'package:flutter_modular/flutter_modular.dart';

import 'modules/base/base_layout.dart';
import 'modules/core/core_module.dart';
import 'modules/login/login_module.dart';
import 'modules/order/order_module.dart';
import 'modules/payment_type/payment_type_module.dart';
import 'modules/products/products_module.dart';

final class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute<LoginModule>('/login', module: LoginModule()),
        ChildRoute<BaseLayout>(
          '/',
          transition: TransitionType.noTransition,
          children: [
            ModuleRoute('/payment-type', module: PaymentTypeModule()),
            ModuleRoute('/products', module: ProductsModule()),
            ModuleRoute('/orders', module: OrderModule()),
          ],
          child: (_, __) => const BaseLayout(body: RouterOutlet()),
        ),
      ];

  @override
  List<Module> get imports => [CoreModule()];
}
