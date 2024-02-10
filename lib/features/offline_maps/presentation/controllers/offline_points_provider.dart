import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pointz/features/points_in_map/domain/entities/point/marker_point_model.dart';
import 'package:pointz/common/presentation/controllers/points_in_map_markers_list_provider.dart';

final offlinePointsProvider = Provider<List<MarkerPoint>>((ref) => ref
    .watch(markersListProvider)
    .map((e) => MarkerPoint(
        id: int.parse(e.markerId.value),
        label: e.infoWindow.title!,
        lat: e.position.latitude,
        lng: e.position.longitude))
    .toList());
