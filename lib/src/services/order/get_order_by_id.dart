import '../../dtos/order/order_dto.dart';
import '../../models/orders/order_model.dart';

abstract interface class GetOrderById {
  Future<OrderDto> call(OrderModel order);
}
