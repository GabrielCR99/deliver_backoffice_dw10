import 'package:flutter/foundation.dart' show immutable;

@immutable
final class UserModel {
  final int id;
  final String name;
  final String email;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: (map['id'] ?? 0) as int,
        name: (map['name'] ?? '') as String,
        email: (map['email'] ?? '') as String,
      );
}
