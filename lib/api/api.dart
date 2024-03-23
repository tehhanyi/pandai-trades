import 'package:dio/dio.dart';

import '../constant.dart';
import 'app_interceptors.dart';

class Api {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: baseUrl));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: 10000,
      connectTimeout: 10000,
      sendTimeout: 10000,
    ));

    dio.interceptors.addAll({AppInterceptors(dio)});
    return dio;
  }
}
