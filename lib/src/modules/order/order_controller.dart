import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../dtos/order/order_dto.dart';
import '../../models/orders/order_model.dart';
import '../../models/orders/order_status.dart';
import '../../repositories/order/order_repository.dart';
import '../../services/order/get_order_by_id.dart';

part 'order_controller.g.dart';

enum OrderStateStatus {
  initial,
  loading,
  success,
  error,
  showDetailModal,
  statusChanged,
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

  @readonly
  OrderDto? _selectedOrder;

  late final DateTime _today;

  final OrderRepository _orderRepository;
  final GetOrderById _getOrderById;

  OrderControllerBase(this._orderRepository, this._getOrderById) {
    final todayNow = DateTime.now();
    _today = DateTime(todayNow.year, todayNow.month, todayNow.day);
  }

  @action
  void changeStatusFilter(OrderStatus? status) {
    _filterStatus = status;
    findOrders();
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
  Future<void> showDetailModal(OrderModel model) async {
    _status = OrderStateStatus.loading;
    _selectedOrder = await _getOrderById(model);
    _status = OrderStateStatus.showDetailModal;
  }

  @action
  Future<void> changeStatus(OrderStatus status) async {
    _status = OrderStateStatus.loading;
    await _orderRepository.changeStatus(id: _selectedOrder!.id, status: status);
    _status = OrderStateStatus.statusChanged;
  }
}
