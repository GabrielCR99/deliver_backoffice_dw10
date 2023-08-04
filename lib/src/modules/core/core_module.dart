import 'package:flutter_modular/flutter_modular.dart';

import '../../core/rest_client/custom_dio.dart';
import '../../core/storage/session_storage.dart';
import '../../core/storage/storage.dart';
import '../../repositories/payment_type/payment_type_repository.dart';
import '../../repositories/payment_type/payment_type_repository_impl.dart';
import '../../repositories/products/products_repository.dart';
import '../../repositories/products/products_repository_impl.dart';
import '../../repositories/user/user_repository.dart';
import '../../repositories/user/user_repository_impl.dart';

final class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    super.exportedBinds(i);
    i
      ..addLazySingleton<Storage>(SessionStorage.new)
      ..addLazySingleton<CustomDio>(CustomDio.new)
      ..addLazySingleton<PaymentTypeRepository>(PaymentTypeRepositoryImpl.new)
      ..addLazySingleton<ProductsRepository>(ProductsRepositoryImpl.new)
      ..addLazySingleton<UserRepository>(UserRepositoryImpl.new);
  }
}
