import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

@immutable
class OrderProductModel {
  final int productId;
  final int amount;
  final double totalPrice;

  const OrderProductModel({
    required this.productId,
    required this.amount,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': productId,
      'amount': amount,
      'total_price': totalPrice,
    };
  }

  factory OrderProductModel.fromMap(Map<String, dynamic> map) {
    return OrderProductModel(
      productId: (map['id'] ?? 0) as int,
      amount: (map['amount'] ?? 0) as int,
      totalPrice: (map['total_price'] ?? 0.0) as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProductModel.fromJson(String source) =>
      OrderProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
