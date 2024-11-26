import '../../models/orders/order_status.dart';
import '../../models/payment_type_model.dart';
import '../../models/user_model.dart';
import 'order_product_dto.dart';

typedef OrderDto = ({
  int id,
  DateTime date,
  OrderStatus status,
  List<OrderProductDto> products,
  UserModel user,
  String address,
  int cpf,
  PaymentTypeModel paymentType,
});
