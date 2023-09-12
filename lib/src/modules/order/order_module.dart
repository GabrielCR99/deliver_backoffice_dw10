import 'package:flutter_modular/flutter_modular.dart';

import '../../repositories/order/order_repository.dart';
import '../../repositories/order/order_repository_impl.dart';
import '../../services/order/get_order_by_id.dart';
import '../../services/order/get_order_by_id_impl.dart';
import '../core/core_module.dart';
import 'order_controller.dart';
import 'order_page.dart';

final class OrderModule extends Module {
  @override
  void binds(Injector i) => i
    ..addLazySingleton<OrderRepository>(OrderRepositoryImpl.new)
    ..addLazySingleton<GetOrderById>(GetOrderByIdImpl.new)
    ..addLazySingleton<OrderController>(OrderController.new);

  @override
  void routes(RouteManager r) => r.child('/', child: (_) => const OrderPage());

  @override
  List<Module> get imports => [CoreModule()];
}
