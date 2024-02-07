import 'package:dio/dio.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

class CustomDio {
  final Dio _client;

  CustomDio() : _client = Dio() {
    _client.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      queryParameters: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      showProcessingTime: true,
      showCUrl: true,
      canShowLog: false,
    ));
  }

  Dio get client => _client;
}
