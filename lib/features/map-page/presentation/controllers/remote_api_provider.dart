import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/common/models/states/network_request_state/core_network_request_state_model.dart';
import 'package:pointz/features/map-page/data/data_sources/remote/map_page_remote_api_data_source.dart';
import 'package:pointz/features/map-page/data/repositories/map_page_remote_api_repository.dart';
import 'package:pointz/features/map-page/domain/entities/point/marker_point_model.dart';
import 'package:pointz/features/map-page/presentation/controllers/markers_list_provider.dart';

import 'marker_creation_provider.dart';

class RemoteApiNotifier extends Notifier<NetworkRequestState> {
  @override
  NetworkRequestState build() {
    return const NetworkRequestState();
  }

  final RemoteApiRepository _remoteApiRepository =
      RemoteApiRepository(remoteApiDataSource: RemoteApiDataSource());

  Future saveMarker() async {
    state = state.copyWith(isLoading: true);
    MarkerPoint markerPointToSave = ref.read(markerPointCreationProvider);
    final resp = await _remoteApiRepository.saveMarker(markerPointToSave);

    resp.fold((exception) {
      state = state.copyWith(
          errorMessage: exception.message, isError: true, data: null);
    }, (id) {
      state = state.copyWith(isError: false, errorMessage: null, data: id);

      // Creates the marker with the same values as the markerPointToSave and the new id, and adds it to the markers list

      String title = markerPointToSave.label;
      LatLng position = LatLng(markerPointToSave.lat, markerPointToSave.lng);
      Marker markerToAddToList = Marker(
        markerId: MarkerId(id.toString()),
        infoWindow: InfoWindow(title: title),
        position: position,
      );

      ref.read(markersListProvider.notifier).addMarker(markerToAddToList);
    });
  }

  Future getMarkers() async {
    state = state.copyWith(isLoading: true);
    final resp = await _remoteApiRepository.getMarkers();

    resp.fold((exception) {
      state = state.copyWith(
          errorMessage: exception.message, isError: true, data: null);
    }, (data) {
      state = state.copyWith(isError: false, errorMessage: null, data: data);
    });
  }

  Future deleteMarker(int id) async {
    state = state.copyWith(isLoading: true);
    final resp = await _remoteApiRepository.deleteMarker(id);

    resp.fold((exception) {
      state = state.copyWith(
          errorMessage: exception.message, isError: true, data: null);
    }, (data) {
      state = state.copyWith(isError: false, errorMessage: null, data: data);
    });
  }

  Future updateMarker(MarkerPoint markerPoint) async {
    state = state.copyWith(isLoading: true);
    final resp =
        await _remoteApiRepository.updateMarker(markerPoint.id, markerPoint);

    resp.fold((exception) {
      state = state.copyWith(
          errorMessage: exception.message, isError: true, data: null);
    }, (data) {
      state = state.copyWith(isError: false, errorMessage: null, data: data);
    });
  }

  Future getMarkerDetails(int id) async {
    state = state.copyWith(isLoading: true);
    final resp = await _remoteApiRepository.getMarkerDetails(id);

    resp.fold((exception) {
      state = state.copyWith(
          errorMessage: exception.message, isError: true, data: null);
    }, (data) {
      state = state.copyWith(isError: false, errorMessage: null, data: data);
    });
  }
}

final remoteApiProvider =
    NotifierProvider<RemoteApiNotifier, NetworkRequestState>(
        () => RemoteApiNotifier());
