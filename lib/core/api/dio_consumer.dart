// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:bimarestan_doctors/core/api/status_code.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../error/exceptions.dart';
import 'api_consumer.dart';
import 'app_interceptors.dart';
import 'end_points.dart';

@LazySingleton(as: ApiConsumer)
class DioConsumer implements ApiConsumer {
  final Dio client;
  DioConsumer({
    required this.client,
  }) {
    (client.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(locator<AppInterceptors>());
  }

  @override
  Future delete(String url) async {
    try {
      final response = await client.delete(url);
      return _handelResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(url, queryParameters: queryParameters);
      return _handelResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(String url,
      {Map<String, dynamic>? body,
      bool formDataIsEnabled = false,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.post(url,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body);
      return _handelResponseAsJson(response);
    } on DioError catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future put(String url,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await client.put(url, queryParameters: queryParameters, data: body);
      return _handelResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handelResponseAsJson(Response<dynamic> response) {
    return json.decode(response.data.toString());
  }

  dynamic _handleDioError(DioError error) {
    debugPrint('error type: ${error.type}');
    switch (error.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw FetchDataException();
      case DioErrorType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw UnauthorizedException();
          case StatusCode.notFound:
            throw NotFoundException();
          case StatusCode.conflict:
            throw ConflictException();
          case StatusCode.internalServerError:
            throw InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.unknown:
        throw NoInternetConnectionException();

      case DioErrorType.badCertificate:
      case DioErrorType.connectionError:
        throw FetchDataException();
    }
  }
}
