import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:pointz/features/points_in_map/domain/entities/point/marker_point_model.dart';

part 'core_local_db_request_state_model.freezed.dart';

@freezed
class LocalDbRequestState with _$LocalDbRequestState {
  const factory LocalDbRequestState({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    dynamic data,
  }) = _LocalDbRequestState;
}
