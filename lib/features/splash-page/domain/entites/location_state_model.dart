import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'location.dart';

part 'location_state_model.freezed.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    @Default(false) isLoading,
    double? latitude,
    double? longitude,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _LocationState;
}
