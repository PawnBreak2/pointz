import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'marker_point_model.freezed.dart';

part 'marker_point_model.g.dart';

@freezed
class MarkerPoint with _$MarkerPoint {
  const factory MarkerPoint({
    required int id,
    required String label,
    required double lat,
    required double lng,
  }) = _MarkerPoint;

  factory MarkerPoint.fromJson(Map<String, dynamic> json) =>
      _$MarkerPointFromJson(json);
}
