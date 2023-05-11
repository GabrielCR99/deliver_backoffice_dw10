import 'dart:developer';
import 'dart:typed_data';

import 'package:mobx/mobx.dart';

import '../../../models/product_model.dart';
import '../../../repositories/products/products_repository.dart';

part 'product_detail_controller.g.dart';

enum ProductDetailStateStatus {
  initial,
  loading,
  success,
  error,
  errorLoadingProduct,
  deleted,
  uploaded,
  saved,
}

final class ProductDetailController = ProductDetailControllerBase
    with _$ProductDetailController;

abstract interface class ProductDetailControllerBase with Store {
  final ProductsRepository _productsRepository;

  @readonly
  var _status = ProductDetailStateStatus.initial;

  @readonly
  String? _errorMessage;

  @readonly
  String? _imagePath;

  ProductDetailControllerBase({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository;

  @action
  Future<void> deleteProduct(int id) async {
    _status = ProductDetailStateStatus.loading;

    try {
      await _productsRepository.delete(id);
      _status = ProductDetailStateStatus.deleted;
    } catch (e, s) {
      log('Erro ao deletar o produto', error: e, stackTrace: s);

      _errorMessage = 'Erro ao deletar o produto';
      _status = ProductDetailStateStatus.error;
    }
  }

  @action
  Future<void> uploadImageProduct(Uint8List file, String fileName) async {
    _status = ProductDetailStateStatus.loading;

    try {
      _imagePath = await _productsRepository.uploadImageProduct(file, fileName);
      _status = ProductDetailStateStatus.uploaded;
    } catch (e, s) {
      log('Erro ao fazer upload da imagem', error: e, stackTrace: s);

      _errorMessage = 'Erro ao fazer upload da imagem';
      _status = ProductDetailStateStatus.error;
    }
  }

  Future<void> save({
    required String name,
    required double price,
    required String description,
  }) async {
    _status = ProductDetailStateStatus.loading;
    final productModel = ProductModel(
      name: name,
      description: description,
      price: price,
      image: _imagePath!,
      enabled: true,
    );

    try {
      await _productsRepository.save(productModel);
      _status = ProductDetailStateStatus.saved;
    } catch (e, s) {
      log('Erro ao salvar o produto', error: e, stackTrace: s);

      _errorMessage = 'Erro ao salvar o produto';
      _status = ProductDetailStateStatus.error;
    }
  }
}
