import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:pointz/features/map-page/domain/entities/point/marker_point_model.dart';
import 'package:pointz/features/map-page/presentation/utils/map_page_strings.dart';

import '../../../../common/models/errors/core_network_error_model.dart';
import '../data_sources/remote/map_page_remote_api_data_source.dart';

class RemoteApiRepository {
  final RemoteApiDataSource remoteApiDataSource;

  RemoteApiRepository({required this.remoteApiDataSource});

  /// Saves the marker to the remote API and returns the marker [int] id

  Future<Either<NetworkError, int>> saveMarker(MarkerPoint markerPoint) async {
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
        int id = data['id'];
        return Right(id);
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
      int id, MarkerPoint data) async {
    final resp =
        await remoteApiDataSource.updateMarker(id.toString(), data.toJson());

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

  Future<Either<NetworkError, MarkerPoint>> getMarkerDetails(int id) async {
    final resp = await remoteApiDataSource.getMarkerDetails(id.toString());

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

  Future<Either<NetworkError, MarkerPoint>> deleteMarker(int id) async {
    final resp = await remoteApiDataSource.deleteMarker(id.toString());

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
