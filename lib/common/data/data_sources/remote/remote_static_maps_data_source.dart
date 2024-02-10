import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pointz/common/network_service/custom_dio.dart';

class RemoteStaticMapsDataSource {
  final dioClient = CustomDio().client;
  final String _apiKey = dotenv.env['GMAPS_API_KEY']!;
  Future<Either<DioException, Uint8List>> saveMapScreenshot(
      double latitude, double longitude) async {
    final Response response = await dioClient.get(
        'https://maps.googleapis.com/maps/api/staticmap?size=262x568&zoom=13&scale=2&markers=size:small|color:0xD727D6|$latitude,$longitude&key=$_apiKey',
        options: Options(responseType: ResponseType.bytes));
    if (response.statusCode == 200 && response != null) {
      Uint8List imageData = response.data;
      return Right(imageData);
    } else {
      return Left(DioException(requestOptions: response.requestOptions));
    }
  }
}
