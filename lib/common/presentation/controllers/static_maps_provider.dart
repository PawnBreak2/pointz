import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pointz/common/data/data_sources/remote/remote_static_maps_data_source.dart';
import 'package:pointz/common/data/repositories/static_maps_repository.dart';

import '../../domain/models/states/network_request_state/core_network_request_state_model.dart';

class StaticMapsNotifier extends Notifier<NetworkRequestState> {
  @override
  NetworkRequestState build() {
    return const NetworkRequestState();
  }

  final StaticMapsRepository _remoteStaticMapsRepository = StaticMapsRepository(
      remoteStaticMapsDataSource: RemoteStaticMapsDataSource());

  Future saveMapScreenshot(
      {required String id, required double lat, required double lng}) async {
    state = state.copyWith(isLoading: true);
    final resp = await _remoteStaticMapsRepository.saveMapScreenshot(
        id: id, lat: lat, lng: lng);

    resp.fold((exception) {
      state = state.copyWith(
          errorMessage: exception.message, isError: true, data: null);
    }, (success) async {
      state = state.copyWith(isError: false, errorMessage: null, data: null);

      // Save the image in file system
    });
  }

  Future<void> deleteMapScreenshot(String id) async {
    state = state.copyWith(isLoading: true);
    final resp = await _remoteStaticMapsRepository.deleteMapScreenshot(id);

    resp.fold((exception) {
      state = state.copyWith(
          errorMessage: exception.message, isError: true, data: null);
    }, (success) {
      state = state.copyWith(isError: false, errorMessage: null, data: null);
    });
  }

  Future getMapScreenshot(String id) async {
    state = state.copyWith(isLoading: true);
    final resp = await _remoteStaticMapsRepository.getMapScreenshot(id);

    resp.fold(
      (exception) {
        state = state.copyWith(
            errorMessage: exception.message,
            isError: true,
            isLoading: false,
            data: null);
      },
      (File? imageFile) {
        state = state.copyWith(
            isError: false,
            errorMessage: null,
            isLoading: false,
            data: imageFile);
      },
    );
  }

  void clearState() {
    state = const NetworkRequestState();
  }
}

final staticMapsProvider =
    NotifierProvider<StaticMapsNotifier, NetworkRequestState>(
        () => StaticMapsNotifier());
