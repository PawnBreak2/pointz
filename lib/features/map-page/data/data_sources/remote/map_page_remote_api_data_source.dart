import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class RemoteApiDataSource {
  final dioClient = Dio();

  Future<Either<DioException, Map<String, String>>> saveMarker(
      Map<String, dynamic> data) async {
    final Response response =
        await dioClient.post('https://api.pointz.com/markers', data: data);

    if (response.statusCode == 201 && response != null) {
      return Right(response.data);
    } else {
      return Left(DioException(requestOptions: response.requestOptions));
    }
  }

  Future<Either<DioException, Map<String, String>>> getMarkers() async {
    final Response response =
        await dioClient.get('https://api.pointz.com/markers');
    if (response.statusCode == 200 && response != null) {
      return Right(response.data);
    } else {
      return Left(DioException(requestOptions: response.requestOptions));
    }
  }

  Future<Either<DioException, Map<String, String>>> getMarkerDetails(
      String id) async {
    final Response response =
        await dioClient.get('https://api.pointz.com/markers/$id');
    if (response.statusCode == 200 && response != null) {
      return Right(response.data);
    } else {
      return Left(DioException(requestOptions: response.requestOptions));
    }
  }

  Future<Either<DioException, Map<String, String>>> deleteMarker(
      String id) async {
    final Response response =
        await dioClient.delete('https://api.pointz.com/markers/$id');

    if (response.statusCode == 200 && response != null) {
      return Right(response.data);
    } else {
      return Left(DioException(requestOptions: response.requestOptions));
    }
  }

  Future<Either<DioException, Map<String, String>>> updateMarker(
      String id, Map data) async {
    final Response response =
        await dioClient.put('https://api.pointz.com/markers/$id', data: data);

    if (response.statusCode == 201 && response != null) {
      return Right(response.data);
    } else {
      return Left(DioException(requestOptions: response.requestOptions));
    }
  }
}
