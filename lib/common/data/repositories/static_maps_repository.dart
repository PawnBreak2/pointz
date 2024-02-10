import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:pointz/common/data/data_sources/remote/remote_static_maps_data_source.dart';
import 'package:pointz/common/domain/interfaces/generic_error_interface.dart';
import 'package:pointz/common/domain/models/errors/core_fs_error_model.dart';
import 'package:pointz/common/presentation/utils/common_strings.dart';

import '../../domain/models/errors/core_network_error_model.dart';
import '../data_sources/local/local_static_map_images_data_source.dart';

class StaticMapsRepository {
  final RemoteStaticMapsDataSource _remoteStaticMapsDataSource;

  StaticMapsRepository({required remoteStaticMapsDataSource})
      : _remoteStaticMapsDataSource = remoteStaticMapsDataSource;

  Future<Either<CustomError, bool>> saveMapScreenshot(
      {required String id, required double lat, required double lng}) async {
    final resp = await _remoteStaticMapsDataSource.saveMapScreenshot(lat, lng);

    return resp.fold(
      (exception) {
        if (exception.message != null) {
          log(exception.message!,
              name: 'StaticMapRepository.saveMapScreenshot Exception');
        }

        if (exception.response == null ||
            exception.response!.statusCode == null) {
          return Left(NetworkError(CommonStrings.failedConnectionError));
        }

        return Left(NetworkError(CommonStrings.genericNetworkError));
      },
      (Uint8List imageFile) async {
        bool resp =
            await LocalStaticMapImagesDataSource.saveImageToLocalFileSystem(
                imageFile, id);
        if (resp) {
          return const Right(true);
        } else {
          return Left((FSError('Errore nel salvataggio della mappa')));
        }
      },
    );
  }

  Future<Either<CustomError, bool>> deleteMapScreenshot(String id) async {
    bool result =
        await LocalStaticMapImagesDataSource.deleteImageFromLocalFileSystem(id);
    if (result) {
      return const Right(true);
    } else {
      return Left(FSError('Errore nella cancellazione della mappa'));
    }
  }

  Future<Either<CustomError, File?>> getMapScreenshot(String id) async {
    File? imageFile =
        await LocalStaticMapImagesDataSource.getImageFromLocalFileSystem(id);
    if (imageFile != null) {
      return Right(imageFile);
    } else {
      return Left(FSError('Errore nel caricamento della mappa'));
    }
  }
}
