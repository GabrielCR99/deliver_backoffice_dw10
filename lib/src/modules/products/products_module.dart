import 'package:flutter_modular/flutter_modular.dart';

import '../core/core_module.dart';
import 'detail/product_detail_controller.dart';
import 'detail/product_detail_page.dart';
import 'home/products_controller.dart';
import 'home/products_page.dart';

final class ProductsModule extends Module {
  @override
  void binds(Injector i) => i
    ..addLazySingleton<ProductsController>(ProductsController.new)
    ..addLazySingleton<ProductDetailController>(ProductDetailController.new);

  @override
  void routes(RouteManager r) => r
    ..child('/', child: (_) => const ProductsPage())
    ..child(
      '/product-detail',
      child: (_) => ProductDetailPage(
        productId: int.tryParse(r.args.queryParams['id'] ?? ''),
      ),
    );

  @override
  List<Module> get imports => [CoreModule()];
}
