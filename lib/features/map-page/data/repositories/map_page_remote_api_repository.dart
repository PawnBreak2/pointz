import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:pointz/features/map-page/domain/entities/point/marker_point_model.dart';
import 'package:pointz/features/map-page/presentation/utils/map_page_strings.dart';

import '../../../../common/models/errors/core_network_error_model.dart';
import '../data_sources/remote/map_page_remote_api_data_source.dart';

class RemoteApiRepository {
  final RemoteApiDataSource remoteApiDataSource;

  RemoteApiRepository({required this.remoteApiDataSource});

  Future<Either<NetworkError, MarkerPoint>> saveMarker(
      MarkerPoint markerPoint) async {
    final resp = await remoteApiDataSource.saveMarker(markerPoint.toJson());

    return resp.fold(
      (exception) {
        if (exception.message != null) {
          log(exception.message!,
              name: 'RemoteApiRepository.saveMarker Exception');
        }

        if (exception.response == null ||
            exception.response!.statusCode == null) {
          return Left(NetworkError(MapPageStrings.failedConnectionError));
        }

        return Left(NetworkError(MapPageStrings.genericNetworkError));
      },
      (data) {
        return Right(MarkerPoint.fromJson(data));
      },
    );
  }

  Future<Either<NetworkError, MarkerPoint>> getMarkers() async {
    final resp = await remoteApiDataSource.getMarkers();

    return resp.fold(
      (exception) {
        if (exception.message != null) {
          log(exception.message!,
              name: 'RemoteApiRepository.getMarkers Exception');
        }

        if (exception.response == null ||
            exception.response!.statusCode == null) {
          return Left(NetworkError(MapPageStrings.failedConnectionError));
        }

        return Left(NetworkError(MapPageStrings.genericNetworkError));
      },
      (data) {
        return Right(MarkerPoint.fromJson(data));
      },
    );
  }

  Future<Either<NetworkError, MarkerPoint>> updateMarker(
      String id, Map<String, dynamic> data) async {
    final resp = await remoteApiDataSource.updateMarker(id, data);

    return resp.fold(
      (exception) {
        if (exception.message != null) {
          log(exception.message!,
              name: 'RemoteApiRepository.updateMarker Exception');
        }

        if (exception.response == null ||
            exception.response!.statusCode == null) {
          return Left(NetworkError(MapPageStrings.failedConnectionError));
        }

        return Left(NetworkError(MapPageStrings.genericNetworkError));
      },
      (data) {
        return Right(MarkerPoint.fromJson(data));
      },
    );
  }

  Future<Either<NetworkError, MarkerPoint>> getMarkerDetails(String id) async {
    final resp = await remoteApiDataSource.getMarkerDetails(id);

    return resp.fold(
      (exception) {
        if (exception.message != null) {
          log(exception.message!,
              name: 'RemoteApiRepository.getMarkerDetails Exception');
        }

        if (exception.response == null ||
            exception.response!.statusCode == null) {
          return Left(NetworkError(MapPageStrings.failedConnectionError));
        }

        return Left(NetworkError(MapPageStrings.genericNetworkError));
      },
      (data) {
        return Right(MarkerPoint.fromJson(data));
      },
    );
  }

  Future<Either<NetworkError, MarkerPoint>> deleteMarker(String id) async {
    final resp = await remoteApiDataSource.deleteMarker(id);

    return resp.fold(
      (exception) {
        if (exception.message != null) {
          log(exception.message!,
              name: 'RemoteApiRepository.deleteMarker Exception');
        }

        if (exception.response == null ||
            exception.response!.statusCode == null) {
          return Left(NetworkError(MapPageStrings.failedConnectionError));
        }

        return Left(NetworkError(MapPageStrings.genericNetworkError));
      },
      (data) {
        return Right(MarkerPoint.fromJson(data));
      },
    );
  }
}
