import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/payment_type_model.dart';
import 'payment_type_repository.dart';

@immutable
final class PaymentTypeRepositoryImpl implements PaymentTypeRepository {
  final CustomDio _dio;

  const PaymentTypeRepositoryImpl(this._dio);

  @override
  Future<List<PaymentTypeModel>> findAll({bool? enabled}) async {
    try {
      final Response(:data) = await _dio.auth().get<List<Object?>>(
        '/payment-types',
        queryParameters: {if (enabled != null) 'enabled': enabled},
      );

      return data!
          .cast<Map<String, dynamic>>()
          .map(PaymentTypeModel.fromMap)
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar formas de pagamento', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(
          message: 'Erro ao buscar formas de pagamento',
        ),
        s,
      );
    }
  }

  @override
  Future<PaymentTypeModel> findById(int id) async {
    try {
      final Response(:data) =
          await _dio.auth().get<Map<String, dynamic>>('/payment-types/$id');

      return PaymentTypeModel.fromMap(data!);
    } on DioException catch (e, s) {
      log('Erro ao buscar formas de pagamento', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(
          message: 'Erro ao buscar formas de pagamento',
        ),
        s,
      );
    }
  }

  @override
  Future<void> save(PaymentTypeModel model) async {
    final CustomDio(:put, :post) = _dio.auth();

    try {
      if (model.id != null) {
        await put<void>('/payment-types/${model.id}', data: model.toMap());

        return;
      }
      await post<void>('/payment-types', data: model.toMap());

      return;
    } on DioException catch (e, s) {
      log('Erro ao salvar forma de pagametno', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(
          message: 'Erro ao salvar forma de pagametno',
        ),
        s,
      );
    }
  }
}
