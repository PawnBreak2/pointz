import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:pointz/common/presentation/utils/common_strings.dart';

import '../../../features/points_in_map/domain/entities/point/marker_point_model.dart';
import '../../domain/models/errors/core_network_error_model.dart';
import '../data_sources/remote/remote_api_data_source.dart';

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
          return Left(NetworkError(CommonStrings.failedConnectionError));
        }

        return Left(NetworkError(CommonStrings.genericNetworkError));
      },
      (data) {
        int id = data['id'];
        return Right(id);
      },
    );
  }

  Future<Either<NetworkError, List<MarkerPoint>>> getMarkers() async {
    final resp = await remoteApiDataSource.getMarkers();

    return resp.fold(
      (exception) {
        if (exception.message != null) {
          log(exception.message!,
              name: 'RemoteApiRepository.getMarkers Exception');
        }

        if (exception.response == null ||
            exception.response!.statusCode == null) {
          return Left(NetworkError(CommonStrings.failedConnectionError));
        }

        return Left(NetworkError(CommonStrings.genericNetworkError));
      },
      (data) {
        List<MarkerPoint> markers =
            (data as List).map((e) => MarkerPoint.fromJson(e)).toList();
        return Right(markers);
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
          return Left(NetworkError(CommonStrings.failedConnectionError));
        }

        return Left(NetworkError(CommonStrings.genericNetworkError));
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
          return Left(NetworkError(CommonStrings.failedConnectionError));
        }

        return Left(NetworkError(CommonStrings.genericNetworkError));
      },
      (data) {
        return Right(MarkerPoint.fromJson(data));
      },
    );
  }

  Future<Either<NetworkError, bool>> deleteMarker(String id) async {
    final resp = await remoteApiDataSource.deleteMarker(id);

    return resp.fold(
      (exception) {
        if (exception.message != null) {
          log(exception.message!,
              name: 'RemoteApiRepository.deleteMarker Exception');
        }

        if (exception.response == null ||
            exception.response!.statusCode == null) {
          return Left(NetworkError(CommonStrings.failedConnectionError));
        }

        return Left(NetworkError(CommonStrings.genericNetworkError));
      },
      (success) {
        return const Right(true);
      },
    );
  }
}
