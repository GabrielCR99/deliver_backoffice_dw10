import 'dart:developer';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/orders/order_model.dart';
import '../../models/orders/order_status.dart';
import 'order_repository.dart';

final class OrderRepositoryImpl implements OrderRepository {
  final CustomDio _dio;

  const OrderRepositoryImpl({required CustomDio dio}) : _dio = dio;

  @override
  Future<void> changeStatus({
    required int id,
    required OrderStatus status,
  }) async {
    try {
      await _dio
          .auth()
          .put<void>('/orders/$id', data: {'status': status.acronym});
    } catch (e, s) {
      log('Erro ao alterar status do pedido', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(message: 'Erro ao alterar status do pedido'),
        s,
      );
    }
  }

  @override
  Future<List<OrderModel>> findAllOrders(
    DateTime date, [
    OrderStatus? status,
  ]) async {
    try {
      final result = await _dio.auth().get<List<Object?>>(
        '/orders',
        queryParameters: {
          'date': date.toIso8601String(),
          if (status != null) 'status': status.acronym,
        },
      );

      return result.data!
          .cast<Map<String, dynamic>>()
          .map<OrderModel>(OrderModel.fromMap)
          .toList();
    } catch (e, s) {
      log('Erro ao buscar pedidos', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(message: 'Erro ao buscar pedidos'),
        s,
      );
    }
  }

  @override
  Future<OrderModel> findById(int id) async {
    try {
      final response =
          await _dio.auth().get<Map<String, dynamic>>('/orders/$id');

      return OrderModel.fromMap(response.data!);
    } catch (e, s) {
      log('Erro ao buscar pedido', error: e, stackTrace: s);

      Error.throwWithStackTrace(
        const RepositoryException(message: 'Erro ao buscar pedido'),
        s,
      );
    }
  }
}
