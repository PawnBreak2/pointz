import 'package:geolocator/geolocator.dart';

import '../../../domain/entites/location.dart';

import 'package:dartz/dartz.dart';

/// Gets the current location of the user
/// Can return a [Position] or an [Exception]

class LocationDataSource {
  Future<Either<Exception, Position>> getLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return Right(position);
    } catch (e) {
      return Left(e as Exception);
    }
  }
}
