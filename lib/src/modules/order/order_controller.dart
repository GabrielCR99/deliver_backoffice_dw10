import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/orders/order_model.dart';
import '../../models/orders/order_status.dart';
import '../../repositories/order/order_repository.dart';
part 'order_controller.g.dart';

enum OrderStateStatus {
  initial,
  loading,
  success,
  error,
  showDetailModal,
}

final class OrderController = OrderControllerBase with _$OrderController;

abstract interface class OrderControllerBase with Store {
  @readonly
  var _status = OrderStateStatus.initial;

  @readonly
  OrderStatus? _filterStatus;

  @readonly
  var _orders = <OrderModel>[];

  @readonly
  String? _errorMessage;

  late final DateTime _today;

  final OrderRepository _orderRepository;

  OrderControllerBase({required OrderRepository orderRepository})
      : _orderRepository = orderRepository {
    final todayNow = DateTime.now();
    _today = DateTime(todayNow.year, todayNow.month, todayNow.day);
  }

  @action
  Future<void> findOrders() async {
    try {
      _status = OrderStateStatus.loading;
      _orders = await _orderRepository.findAllOrders(_today, _filterStatus);
      _status = OrderStateStatus.success;
    } catch (e, s) {
      log('Erro ao buscar os pedidos', error: e, stackTrace: s);

      _status = OrderStateStatus.error;
      _errorMessage = 'Erro ao buscar os pedidos';
    }
  }

  @action
  Future<void> showDetailModal() async {
    _status = OrderStateStatus.loading;
    await Future<void>.delayed(Duration.zero);
    _status = OrderStateStatus.showDetailModal;
  }
}
