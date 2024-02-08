import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entities/point/marker_point_model.dart';
import '../utils/points_in_map_constants.dart';
import 'points_in_map_markers_list_provider.dart';

/// Used to manage the visualizations of the marker point creation.
///
/// This provider is meant to be loaded in the Map page during the visualization / update of marker details, and be disposed / invalidated when the process is over.

class MarkerPointDetailNotifier extends Notifier<MarkerPoint> {
  @override
  MarkerPoint build() {
    return const MarkerPoint(id: null, label: '', lat: 0, lng: 0);
  }

  void setLabel(String label) {
    state = state.copyWith(label: label);
  }

  void clearMarkerPoint() {
    state = const MarkerPoint(id: null, label: '', lat: 0, lng: 0);
  }

  void populateMarkerPoint(MarkerPoint markerPoint) {
    state = markerPoint;
  }
}

final markerPointDetailProvider =
    NotifierProvider<MarkerPointDetailNotifier, MarkerPoint>(
        () => MarkerPointDetailNotifier());