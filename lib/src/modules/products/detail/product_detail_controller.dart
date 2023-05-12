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

  @readonly
  ProductModel? _productModel;

  ProductDetailControllerBase({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository;

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

  @action
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
      enabled: _productModel?.enabled ?? true,
      id: _productModel?.id,
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

  @action
  Future<void> loadProduct(int? id) async {
    _status = ProductDetailStateStatus.loading;
    _productModel = null;
    _imagePath = null;

    try {
      if (id != null) {
        _productModel = await _productsRepository.findById(id);
        _imagePath = _productModel!.image;
      }
      _status = ProductDetailStateStatus.success;
    } catch (e, s) {
      log('Erro ao buscar o produto', error: e, stackTrace: s);

      _errorMessage = 'Erro ao buscar o produto';
      _status = ProductDetailStateStatus.errorLoadingProduct;
    }
  }

  @action
  Future<void> deleteProduct() async {
    _status = ProductDetailStateStatus.loading;

    try {
      if (_productModel != null && _productModel!.id != null) {
        await _productsRepository.delete(_productModel!.id!);
        _status = ProductDetailStateStatus.deleted;
      }
      await Future<void>.delayed(Duration.zero);
      _status = ProductDetailStateStatus.deleted;
      _errorMessage = 'Produto não cadastrado, não é possível deletar';
    } catch (e, s) {
      log('Erro ao deletar o produto', error: e, stackTrace: s);

      _errorMessage = 'Erro ao deletar o produto';
      _status = ProductDetailStateStatus.error;
    }
  }
}
