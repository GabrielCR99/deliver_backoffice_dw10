import 'package:flutter/foundation.dart' show immutable;

@immutable
final class AuthModel {
  final String accessToken;

  const AuthModel({required this.accessToken});

  Map<String, dynamic> toMap() => {'access_token': accessToken};

  factory AuthModel.fromMap(Map<String, dynamic> map) =>
      AuthModel(accessToken: (map['access_token'] ?? '') as String);
}
