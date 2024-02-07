import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'core_network_request_state_model.freezed.dart';

@freezed
class NetworkRequestState with _$NetworkRequestState {
  const factory NetworkRequestState({
    @Default(false) bool isLoading, // Corrected: Added 'bool' type annotation
    @Default(false) bool isError,
    dynamic data,
    String? errorMessage,
  }) = _NetworkRequestState;
}
