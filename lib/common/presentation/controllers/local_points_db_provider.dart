import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/common/data/data_sources/local/local_points_db_data_source.dart';

import '../../../features/points_in_map/domain/entities/point/marker_point_model.dart';
import 'points_in_map_markers_list_provider.dart';
import '../../data/repositories/local_points_db_repository.dart';
import '../../domain/models/states/local_db_request_state/core_local_db_request_state_model.dart';

class LocalDbNotifier extends Notifier<LocalDbRequestState> {
  @override
  LocalDbRequestState build() {
    return const LocalDbRequestState();
  }

  final LocalPointsDbRepository _localPointsDbRepository =
      LocalPointsDbRepository(
          localPointsDbDataSource: LocalPointsDbDataSource());

  Future<bool> saveMarker(MarkerPoint markerPoint) async {
    state = state.copyWith(isLoading: true);
    final success = await _localPointsDbRepository.saveMarker(markerPoint);

    if (success) {
      state = state.copyWith(isError: false, data: success);
      clearState();
      return true;
    } else {
      state = state.copyWith(isLoading: false, isError: true, data: null);
      clearState();
      return false;
    }
  }

  Future<bool> saveMarkers(List<MarkerPoint> markersList) async {
    state = state.copyWith(isLoading: true);
    final success = await _localPointsDbRepository.saveMarkers(markersList);

    if (success) {
      state = state.copyWith(isError: false, isLoading: false, data: success);
      clearState();
      return true;
    } else {
      state = state.copyWith(isLoading: false, isError: true, data: null);
      clearState();
      return false;
    }
  }

  Future getMarkers() async {
    state = state.copyWith(isLoading: true);

    final result = await _localPointsDbRepository.getMarkers();
    result.fold(
      (isFailure) => state = state.copyWith(isLoading: false, isError: true),
      (data) {
        state = state.copyWith(isLoading: false, isError: false, data: data);
        List<MarkerPoint> markerPointsToBeConverted = List.from(state.data);
        Set<Marker> mapMarkersToAdd = markerPointsToBeConverted
            .toSet()
            .map((e) => Marker(
                  markerId: MarkerId(e.id.toString()),
                  infoWindow: InfoWindow(title: e.label.toString()),
                  position: LatLng(e.lat, e.lng),
                ))
            .toSet();
        ref.read(markersListProvider.notifier).addMarkersList(mapMarkersToAdd);
      },
    );
    clearState();
  }

  Future<bool> deleteMarker(int id) async {
    state = state.copyWith(isLoading: true);
    final success = await _localPointsDbRepository.deleteMarker(id);

    if (success) {
      state = state.copyWith(isLoading: false, isError: false);
      clearState();
      return true;
    } else {
      state = state.copyWith(isLoading: false, isError: true, data: null);
      clearState();
      return false;
    }
  }

  Future<bool> updateMarker(MarkerPoint markerPoint) async {
    state = state.copyWith(isLoading: true);
    final success = await _localPointsDbRepository.updateMarker(markerPoint);

    if (success) {
      state = state.copyWith(isError: false, data: success);
      state = state.copyWith(isLoading: false);
      clearState();
      return true;
    } else {
      state = state.copyWith(isLoading: false, isError: true, data: null);
      clearState();
      return false;
    }
  }

  void clearState() {
    state = const LocalDbRequestState();
  }
}

final localDbProvider = NotifierProvider<LocalDbNotifier, LocalDbRequestState>(
    () => LocalDbNotifier());
