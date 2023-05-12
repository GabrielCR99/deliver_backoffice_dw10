import '../../models/orders/order_model.dart';
import '../../models/orders/order_status.dart';

abstract interface class OrderRepository {
  Future<List<OrderModel>> findAllOrders(DateTime date, [OrderStatus? status]);
  Future<OrderModel> findById(int id);
  Future<void> changeStatus({required int id, required OrderStatus status});
}
