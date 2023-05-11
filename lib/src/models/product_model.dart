import 'package:flutter/foundation.dart' show immutable;

@immutable
final class ProductModel {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String image;
  final bool enabled;

  const ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.enabled,
    this.id,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'image': image,
        'enabled': enabled,
      };

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        name: map['name'] as String,
        description: map['description'] as String,
        price: map['price'] as double,
        image: map['image'] as String,
        enabled: map['enabled'] as bool,
        id: map['id'] as int?,
      );
}
