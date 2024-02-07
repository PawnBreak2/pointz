import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pointz/features/splash-page/data/data_sources/local/location_data_source.dart';
import 'package:pointz/features/splash-page/data/data_sources/local/permission_data_source.dart';

import '../../data/repositories/location_repository.dart';
import '../../domain/entites/location_state_model.dart';

class LocationController extends AutoDisposeNotifier<LocationState> {
  @override
  LocationState build() {
    return LocationState();
  }

  getLocation() async {
    state = state.copyWith(isLoading: true);
    LocationDataSource locationDataSource = LocationDataSource();
    PermissionDataSource permissionDataSource = PermissionDataSource();
    LocationRepository locationRepository = LocationRepository(
        locationDataSource: locationDataSource,
        permissionDataSource: permissionDataSource);
    final resp = await locationRepository.getLocation();
    resp.fold((l) {
      state = state.copyWith(
        errorMessage: l.message,
        isError: true,
      );
    }, (r) {
      state = state.copyWith(
          latitude: r.latitude,
          longitude: r.longitude,
          isError: false,
          errorMessage: null);
    });

    // Just to show the loading indicator

    state = state.copyWith(isLoading: false);
  }
}

final locationControllerProvider =
    NotifierProvider.autoDispose<LocationController, LocationState>(
        () => LocationController());
