import 'package:flutter_modular/flutter_modular.dart';

import 'detail/product_detail_controller.dart';
import 'detail/product_detail_page.dart';
import 'home/products_controller.dart';
import 'home/products_page.dart';

final class ProductsModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i
      ..addLazySingleton<ProductsController>(ProductsController.new)
      ..addLazySingleton<ProductDetailController>(ProductDetailController.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r
      ..child('/', child: (_) => const ProductsPage())
      ..child(
        '/product-detail',
        child: (_) => ProductDetailPage(
          productId: int.tryParse(r.args.queryParams['id'] ?? ''),
        ),
      );
  }
}
