import 'package:flutter_modular/flutter_modular.dart';

import 'payment_type_controller.dart';
import 'payment_type_page.dart';

final class PaymentTypeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton(
          (i) => PaymentTypeController(paymentTypeRepository: i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute<PaymentTypePage>(
          '/',
          child: (_, __) => const PaymentTypePage(),
        ),
      ];
}
