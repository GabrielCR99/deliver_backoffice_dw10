import 'package:flutter/foundation.dart' show immutable;

@immutable
final class OrderProductModel {
  final int productId;
  final int amount;
  final double totalPrice;

  const OrderProductModel({
    required this.productId,
    required this.amount,
    required this.totalPrice,
  });

  factory OrderProductModel.fromMap(Map<String, dynamic> map) =>
      OrderProductModel(
        productId: (map['id'] ?? 0) as int,
        amount: (map['amount'] ?? 0) as int,
        totalPrice: (map['total_price'] ?? 0.0) as double,
      );
}
