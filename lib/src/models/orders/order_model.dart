import 'package:flutter/foundation.dart' show immutable;

import 'order_product_model.dart';
import 'order_status.dart';

@immutable
final class OrderModel {
  final int id;
  final DateTime date;
  final OrderStatus status;
  final List<OrderProductModel> products;
  final int userId;
  final String address;
  final int cpf;
  final int paymentTypeId;

  const OrderModel({
    required this.id,
    required this.date,
    required this.status,
    required this.products,
    required this.userId,
    required this.address,
    required this.cpf,
    required this.paymentTypeId,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'date': date.toIso8601String(),
        'status': status.acronym,
        'products': products.map((x) => x.toMap()).toList(),
        'user_id': userId,
        'address': address,
        'cpf': cpf,
        'payment_type_id': paymentTypeId,
      };

  factory OrderModel.fromMap(Map<String, dynamic> map) => OrderModel(
        id: map['id'] as int,
        date: DateTime.parse(map['date'] as String),
        status: OrderStatus.parse(map['status'] as String),
        products: List<OrderProductModel>.of(
          (map['products'] as List<Object?>).map<OrderProductModel>(
            (x) => OrderProductModel.fromMap(
              x as Map<String, dynamic>? ?? const {},
            ),
          ),
        ),
        userId: map['user_id'] as int,
        address: map['address'] as String,
        cpf: map['CPF'] as int,
        paymentTypeId: map['payment_method_id'] as int,
      );
}
