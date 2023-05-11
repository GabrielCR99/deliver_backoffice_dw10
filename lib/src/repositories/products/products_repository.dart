import 'package:flutter/foundation.dart';

import '../../models/product_model.dart';

abstract interface class ProductsRepository {
  Future<List<ProductModel>> findAll({String? name});
  Future<void> save(ProductModel model);
  Future<ProductModel> findById(int id);
  Future<String> uploadImageProduct(Uint8List image, String name);
  Future<void> delete(int id);
}
