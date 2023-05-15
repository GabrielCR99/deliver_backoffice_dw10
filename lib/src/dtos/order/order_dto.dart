import 'package:flutter/foundation.dart' show immutable;

import '../../models/orders/order_status.dart';
import '../../models/payment_type_model.dart';
import '../../models/user_model.dart';
import 'order_product_dto.dart';

@immutable
final class OrderDto {
  final int id;
  final DateTime date;
  final OrderStatus status;
  final List<OrderProductDto> products;
  final UserModel user;
  final String address;
  final int cpf;
  final PaymentTypeModel paymentType;

  const OrderDto({
    required this.id,
    required this.date,
    required this.status,
    required this.products,
    required this.user,
    required this.address,
    required this.cpf,
    required this.paymentType,
  });
}
