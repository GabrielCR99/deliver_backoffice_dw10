import 'package:flutter/foundation.dart' show immutable;

@immutable
class PaymentTypeModel {
  final int? id;
  final String name;
  final String acronym;
  final bool enabled;

  const PaymentTypeModel({
    required this.name,
    required this.acronym,
    required this.enabled,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'acronym': acronym,
      'enabled': enabled,
    };
  }

  factory PaymentTypeModel.fromMap(Map<String, dynamic> map) {
    return PaymentTypeModel(
      name: map['name'] as String,
      acronym: map['acronym'] as String,
      enabled: map['enabled'] as bool,
      id: map['id'] as int?,
    );
  }
}
