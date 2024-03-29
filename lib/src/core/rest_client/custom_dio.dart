import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

import '../env/env.dart';
import '../storage/storage.dart';
import 'interceptors/auth_interceptor.dart';

final class CustomDio extends DioForBrowser {
  late final AuthInterceptor _authInterceptor;

  CustomDio(Storage storage)
      : super(
          BaseOptions(
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 60),
            baseUrl: Env.instance.get('backend_base_url'),
          ),
        ) {
    interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    _authInterceptor = AuthInterceptor(storage);
  }

  CustomDio auth() {
    if (!interceptors.contains(_authInterceptor)) {
      return this..interceptors.add(_authInterceptor);
    }

    return this..interceptors;
  }

  CustomDio unauth() => this..interceptors.remove(_authInterceptor);
}
