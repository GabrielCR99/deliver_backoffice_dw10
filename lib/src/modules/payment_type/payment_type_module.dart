import 'package:flutter_modular/flutter_modular.dart';

import '../core/core_module.dart';
import 'payment_type_controller.dart';
import 'payment_type_page.dart';

final class PaymentTypeModule extends Module {
  @override
  void binds(Injector i) =>
      i.addLazySingleton<PaymentTypeController>(PaymentTypeController.new);

  @override
  void routes(RouteManager r) =>
      r.child('/', child: (_) => const PaymentTypePage());

  @override
  List<Module> get imports => [CoreModule()];
}
