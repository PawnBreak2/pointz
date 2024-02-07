import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/features/map-page/presentation/controllers/markers_list_provider.dart';
import 'package:pointz/features/map-page/presentation/utils/map_page_constants.dart';

import '../../domain/entities/point/marker_point_model.dart';

class MarkerPointCreationNotifier extends Notifier<MarkerPoint> {
  @override
  MarkerPoint build() {
    return const MarkerPoint(id: null, label: '', lat: 0, lng: 0);
  }

  void setLabel(String label) {
    state = state.copyWith(label: label);
  }

  void setLatAndLng(double lat, double lng) {
    state = state.copyWith(lat: lat, lng: lng);
  }

  void setId(int id) {
    state = state.copyWith(id: id);
  }

  void clearMarkerPoint() {
    state = const MarkerPoint(id: null, label: '', lat: 0, lng: 0);
  }

  void addMarkerToList() {
    ref.read(markersListProvider.notifier).addMarker(
          Marker(
              markerId: MarkerId(state.id.toString()),
              position: LatLng(state.lat, state.lng),
              infoWindow: InfoWindow(title: state.label),
              icon: MapPageConstants.markerIcon),
        );
  }
}

final markerPointCreationProvider =
    NotifierProvider<MarkerPointCreationNotifier, MarkerPoint>(
        () => MarkerPointCreationNotifier());
