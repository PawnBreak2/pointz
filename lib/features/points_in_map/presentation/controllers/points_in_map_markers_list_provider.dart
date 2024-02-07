import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersListNotifier extends Notifier<Set<Marker>> {
  @override
  build() {
    return {};
  }

  void addMarker(Marker marker) {
    state = {...state, marker};
    print(state);
  }

  void addMarkersList(Set<Marker> markers) {
    state = markers;
  }

  void removeMarkerById(String id) {
    state = state.where((element) => element.markerId.value != id).toSet();
  }

  void updateMarker(Marker marker) {
    state = state
        .map((e) => e.markerId.value == marker.markerId.value ? marker : e)
        .toSet();
    print(state);
  }

  void clearMarkers() {
    state = {};
  }
}

final markersListProvider = NotifierProvider<MarkersListNotifier, Set<Marker>>(
    () => MarkersListNotifier());
