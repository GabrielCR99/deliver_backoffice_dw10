import 'dart:io';

import 'package:dio/dio.dart';

import '../../global/constants.dart';
import '../../global/global_context.dart';
import '../../storage/storage.dart';

final class AuthInterceptor extends Interceptor {
  final Storage _storage;

  AuthInterceptor(this._storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = _storage.getData(SessionStorageKeys.accessToken.key);
    options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      GlobalContext.instance.loginExpired();

      return;
    }

    return handler.next(err);
  }
}
