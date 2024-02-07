import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/features/points_in_map/presentation/controllers/points_in_map_marker_detail_provider.dart';

import '../../../features/points_in_map/domain/entities/point/marker_point_model.dart';
import '../../../features/points_in_map/presentation/controllers/points_in_map_marker_creation_provider.dart';
import '../../../features/points_in_map/presentation/controllers/points_in_map_markers_list_provider.dart';
import '../../data/data_sources/remote/remote_api_data_source.dart';
import '../../data/repositories/remote_api_repository.dart';
import '../../domain/models/states/network_request_state/core_network_request_state_model.dart';

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
      print(data);
      state = state.copyWith(isError: false, errorMessage: null, data: data);
      List<MarkerPoint> markerPointsToBeConverted = List.from(state.data);
      Set<Marker> mapMarkersToAdd = markerPointsToBeConverted
          .toSet()
          .map((e) => Marker(
                markerId: MarkerId(e.id.toString()),
                infoWindow: InfoWindow(title: e.label.toString()),
                position: LatLng(e.lat, e.lng),
              ))
          .toSet();
      ref.read(markersListProvider.notifier).addMarkersList(mapMarkersToAdd);
    });
    state = state.copyWith(isLoading: false);
    clearState();
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

    state = state.copyWith(isLoading: false);
  }

  Future updateMarker(MarkerPoint markerPoint) async {
    print('updating marker');
    state = state.copyWith(isLoading: true);
    final resp =
        await _remoteApiRepository.updateMarker(markerPoint.id!, markerPoint);

    resp.fold((exception) {
      state = state.copyWith(
          errorMessage: exception.message, isError: true, data: null);
    }, (data) {
      state = state.copyWith(isError: false, errorMessage: null, data: data);
      MarkerPoint markerPointToBeConverted = state.data;
      String id = markerPointToBeConverted.id.toString();
      String title = markerPointToBeConverted.label;
      LatLng position =
          LatLng(markerPointToBeConverted.lat, markerPointToBeConverted.lng);

      Marker mapMarkerToUpdate = Marker(
        markerId: MarkerId(id),
        infoWindow: InfoWindow(title: title),
        position: position,
      );
      print('here');
      ref.read(markersListProvider.notifier).updateMarker(mapMarkerToUpdate);
    });
    state = state.copyWith(isLoading: false);
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
    state = state.copyWith(isLoading: true);
  }

  void clearState() {
    state = const NetworkRequestState();
  }
}

final remoteApiProvider =
    NotifierProvider<RemoteApiNotifier, NetworkRequestState>(
        () => RemoteApiNotifier());
