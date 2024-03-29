import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../../models/product_model.dart';
import '../../../repositories/products/products_repository.dart';

part 'products_controller.g.dart';

enum ProductStateStatus {
  initial,
  loading,
  success,
  error,
  addOrUpdateProduct,
}

final class ProductsController = ProductsControllerBase
    with _$ProductsController;

abstract interface class ProductsControllerBase with Store {
  @readonly
  var _status = ProductStateStatus.initial;

  @readonly
  String? _filterName;

  @readonly
  var _products = <ProductModel>[];

  @readonly
  ProductModel? _selectedProduct;

  final ProductsRepository _productsRepository;

  ProductsControllerBase(this._productsRepository);

  @action
  Future<void> getProducts() async {
    _status = ProductStateStatus.loading;

    try {
      _products = await _productsRepository.findAll(name: _filterName);
      _status = ProductStateStatus.success;
    } catch (e, s) {
      log('Erro ao buscar os produtos', error: e, stackTrace: s);

      _status = ProductStateStatus.error;
    }
  }

  @action
  Future<void> filterByName(String name) async {
    _filterName = name;
    await getProducts();
  }

  @action
  Future<void> addProduct() async {
    _status = ProductStateStatus.loading;
    await Future<void>.delayed(Duration.zero);
    _selectedProduct = null;
    _status = ProductStateStatus.addOrUpdateProduct;
  }

  @action
  Future<void> editProduct(ProductModel productModel) async {
    _status = ProductStateStatus.loading;
    await Future<void>.delayed(Duration.zero);
    _selectedProduct = productModel;
    _status = ProductStateStatus.addOrUpdateProduct;
  }
}
