import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pointz/common/models/errors/location_error_model.dart';
import 'package:pointz/features/splash-page/data/data_sources/local/permission_data_source.dart';
import 'package:pointz/features/splash-page/presentation/utils/splash_page_strings.dart';

import '../../domain/entites/location.dart';
import '../data_sources/local/location_data_source.dart';

class LocationRepository {
  final LocationDataSource locationDataSource;
  final PermissionDataSource permissionDataSource;

  LocationRepository(
      {required this.locationDataSource, required this.permissionDataSource});

  Future<Either<LocationError, Location>> getLocation() async {
    bool isPermitted = await permissionDataSource.requestPermission();

    if (isPermitted) {
      final resp = await locationDataSource.getLocation();

      return resp.fold(
        (exception) {
          late String message;
          switch (exception.runtimeType) {
            case LocationServiceDisabledException:
              message = SplashPageStrings.locationDisabledError;

            case PermissionDeniedException:
              message = SplashPageStrings.permissionDeniedError;

            default:
              message = SplashPageStrings.genericError;
          }

          return Left(LocationError(message));
        },
        (position) {
          return Right(Location(
              latitude: position.latitude, longitude: position.longitude));
        },
      );
    } else {
      return Left(LocationError(SplashPageStrings.permissionDeniedError));
    }
  }
}
