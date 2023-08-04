import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/product_model.dart';
import 'products_repository.dart';

final class ProductsRepositoryImpl implements ProductsRepository {
  final CustomDio _dio;

  const ProductsRepositoryImpl(this._dio);

  @override
  Future<void> delete(int id) async {
    try {
      await _dio
          .auth()
          .put<Map<String, dynamic>>('/products/$id', data: {'enabled': false});
    } on DioException catch (e, s) {
      log('Erro ao desabilitar produto', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(
          message: 'Erro ao desabilitar produto',
        ),
        s,
      );
    }
  }

  @override
  Future<List<ProductModel>> findAll({String? name}) async {
    try {
      final Response(:data) = await _dio.auth().get<List<Object?>>(
        '/products',
        queryParameters: {
          if (name != null) 'name': name,
          'enabled': true,
        },
      );

      return data!
          .cast<Map<String, dynamic>>()
          .map(ProductModel.fromMap)
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(message: 'Erro ao buscar produtos'),
        s,
      );
    }
  }

  @override
  Future<ProductModel> findById(int id) async {
    try {
      final Response(:data) =
          await _dio.auth().get<Map<String, dynamic>>('/products/$id');

      return ProductModel.fromMap(data!);
    } on DioException catch (e, s) {
      log('Erro ao buscar produto $id', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        RepositoryException(message: 'Erro ao buscar produto $id'),
        s,
      );
    }
  }

  @override
  Future<void> save(ProductModel model) async {
    try {
      final CustomDio(:put, :post) = _dio.auth();
      final data = model.toMap();

      if (model.id != null) {
        await put<void>('/products/${model.id}', data: data);

        return;
      }

      await post<void>('/products', data: data);
    } on DioException catch (e, s) {
      log('Erro ao salvar produto', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(message: 'Erro ao salvar produto'),
        s,
      );
    }
  }

  @override
  Future<String> uploadImageProduct(Uint8List image, String name) async {
    try {
      final formData = FormData.fromMap(
        {'file': MultipartFile.fromBytes(image, filename: name)},
      );

      final Response(:data) = await _dio
          .auth()
          .post<Map<String, dynamic>>('/uploads', data: formData);

      return data!['url'] as String;
    } on DioException catch (e, s) {
      log('Erro ao fazer upload da imagem', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(message: 'Erro ao fazer upload da imagem'),
        s,
      );
    }
  }
}
