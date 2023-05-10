import 'dart:html';

import 'storage.dart';

class SessionStorage implements Storage {
  @override
  void clearData() => window.sessionStorage.clear();

  @override
  String getData(String key) => window.sessionStorage[key] ?? '';

  @override
  void setData({required String key, required String value}) =>
      window.sessionStorage[key] = value;
}
