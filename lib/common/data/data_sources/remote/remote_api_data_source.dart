import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pointz/common/network_service/custom_dio.dart';

class RemoteApiDataSource {
  final dioClient = CustomDio().client;

  Future<Either<DioException, Map<String, dynamic>>> saveMarker(
      Map<String, dynamic> data) async {
    final Response response = await dioClient.post(
        'https://906f04d8ee93.ngrok.app/api/points?caller=dario',
        data: data);

    if (response.statusCode == 201 && response != null) {
      return Right(response.data);
    } else {
      return Left(DioException(requestOptions: response.requestOptions));
    }
  }

  Future<Either<DioException, List<dynamic>>> getMarkers() async {
    final Response response = await dioClient
        .get('https://906f04d8ee93.ngrok.app/api/points?caller=dario');
    if (response.statusCode == 200 && response != null) {
      return Right(response.data);
    } else {
      return Left(DioException(requestOptions: response.requestOptions));
    }
  }

  Future<Either<DioException, Map<String, dynamic>>> getMarkerDetails(
      String id) async {
    final Response response = await dioClient
        .get('https://906f04d8ee93.ngrok.app/api/points/$id?caller=dario');
    if (response.statusCode == 200 && response != null) {
      return Right(response.data);
    } else {
      return Left(DioException(requestOptions: response.requestOptions));
    }
  }

  Future<Either<DioException, bool>> deleteMarker(String id) async {
    final Response response = await dioClient
        .delete('https://906f04d8ee93.ngrok.app/api/points/$id?caller=dario');

    if (response.statusCode == 200 && response != null) {
      return const Right(true);
    } else {
      return Left(DioException(requestOptions: response.requestOptions));
    }
  }

  Future<Either<DioException, Map<String, dynamic>>> updateMarker(
      String id, Map data) async {
    final Response response = await dioClient.put(
        'https://906f04d8ee93.ngrok.app/api/points/$id?caller=dario',
        data: data);

    if (response.statusCode == 200 && response != null) {
      return Right(response.data);
    } else {
      return Left(DioException(requestOptions: response.requestOptions));
    }
  }
}
