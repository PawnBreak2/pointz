import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pointz/common/models/states/network_request_state/core_network_request_state_model.dart';
import 'package:pointz/features/map-page/data/data_sources/remote/map_page_remote_api_data_source.dart';
import 'package:pointz/features/map-page/data/repositories/map_page_remote_api_repository.dart';
import 'package:pointz/features/map-page/domain/entities/point/marker_point_model.dart';

class RemoteApiProvider extends Notifier<NetworkRequestState> {
  @override
  NetworkRequestState build() {
    return const NetworkRequestState();
  }

  final RemoteApiRepository _remoteApiRepository =
      RemoteApiRepository(remoteApiDataSource: RemoteApiDataSource());

  Future saveMarker(MarkerPoint markerPoint) async {
    state = state.copyWith(isLoading: true);
    final resp = await _remoteApiRepository.saveMarker(markerPoint);

    resp.fold((exception) {
      state = state.copyWith(
          errorMessage: exception.message, isError: true, data: null);
    }, (data) {
      state = state.copyWith(isError: false, errorMessage: null, data: data);
    });
  }
}
