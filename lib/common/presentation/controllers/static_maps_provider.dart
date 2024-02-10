import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/common/data/data_sources/remote/remote_static_maps_data_source.dart';
import 'package:pointz/common/data/repositories/static_maps_repository.dart';
import 'package:pointz/common/presentation/controllers/local_points_db_provider.dart';
import 'package:pointz/features/points_in_map/presentation/controllers/points_in_map_marker_detail_provider.dart';

import '../../../features/points_in_map/domain/entities/point/marker_point_model.dart';
import '../../../features/points_in_map/presentation/controllers/points_in_map_marker_creation_provider.dart';
import 'points_in_map_markers_list_provider.dart';
import '../../data/data_sources/remote/remote_api_data_source.dart';
import '../../data/repositories/remote_api_repository.dart';
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
