import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/features/splash-page/domain/entites/location.dart';

import '../../../splash-page/presentation/controllers/location_controller_provider.dart';
import 'points_in_map_constants.dart';

final userInitialPosition = Provider<CameraPosition>((ref) {
  // If the location data is not available for some reason, the default location is Rome

  Location defaultInitialPosition = Location(
    latitude: 41.893056,
    longitude: 12.482778,
  );
  double? initialLat = ref.read(locationControllerProvider).latitude;
  double? initialLong = ref.read(locationControllerProvider).longitude;
  if (initialLat != null && initialLong != null) {
    return CameraPosition(
      target: LatLng(initialLat, initialLong),
      zoom: MapPageConstants.defaultZoomLevel,
    );
  } else {
    return CameraPosition(
      target: LatLng(
          defaultInitialPosition.latitude, defaultInitialPosition.longitude),
      zoom: MapPageConstants.defaultZoomLevel,
    );
  }
});
