import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/common/data/data_sources/local/local_db_data_source.dart';

import '../../../features/points_in_map/domain/entities/point/marker_point_model.dart';
import '../../data/repositories/local_db_repository.dart';
import '../../domain/models/states/local_db_request_state/core_local_db_request_state_model.dart';

class LocalDbNotifier extends Notifier<LocalDbRequestState> {
  @override
  LocalDbRequestState build() {
    return const LocalDbRequestState();
  }

  final LocalDbRepository _localDbRepository =
      LocalDbRepository(localDbDataSource: LocalDbDataSource());

  Future saveMarker(MarkerPoint markerPoint) async {
    state = state.copyWith(isLoading: true);
    final success = await _localDbRepository.saveMarker(markerPoint);

    if (success) {
      state = state.copyWith(isLoading: false, isError: false, data: null);
      // Optionally, update the UI or markers list here if needed
    } else {
      state = state.copyWith(isLoading: false, isError: true, data: null);
    }
  }

  Future getMarkers() async {
    state = state.copyWith(isLoading: true);

    final result = await _localDbRepository.getMarkers();
    result.fold(
      (isFailure) => state = state.copyWith(isLoading: false, isError: true),
      (markers) {
        state = state.copyWith(isLoading: false, isError: false, data: markers);
        // Convert MarkerPoints to Google Maps Markers and update the UI as needed
      },
    );
  }

  Future deleteMarker(int id) async {
    state = state.copyWith(isLoading: true);
    final success = await _localDbRepository.deleteMarker(id);

    if (success) {
      state = state.copyWith(isLoading: false, isError: false);
      // Optionally, update the markers list here if needed
    } else {
      state = state.copyWith(isLoading: false, isError: true, data: null);
    }
  }

  Future updateMarker(MarkerPoint markerPoint) async {
    state = state.copyWith(isLoading: true);
    final success = await _localDbRepository.updateMarker(markerPoint);

    if (success) {
      state = state.copyWith(isLoading: false, isError: false);
    } else {
      state = state.copyWith(isLoading: false, isError: true, data: null);
    }
  }
}

final localDbProvider = NotifierProvider<LocalDbNotifier, LocalDbRequestState>(
    () => LocalDbNotifier());
