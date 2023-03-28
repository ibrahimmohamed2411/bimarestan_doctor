// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../features/user/data/datasources/user_local_data_source.dart';
import '../../features/user/data/models/login_response_model.dart';
import '../resources/app_strings.dart';

@lazySingleton
class AppInterceptors extends Interceptor {
  // final LangLocalDataSource langLocalDataSource;
  final UserLocalDataSource userLocalDataSource;
  AppInterceptors({
    // required this.langLocalDataSource,
    required this.userLocalDataSource,
  });
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    LoginResponseModel? credentials =
        await userLocalDataSource.getUserCredentials();

    if (credentials != null) {
      options.headers['Authorization'] = 'Bearer ${credentials.token}';
    }

    options.headers['content-Type'] = Headers.jsonContentType;

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}
