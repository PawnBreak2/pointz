import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/common/presentation/controllers/local_points_db_provider.dart';
import 'package:pointz/common/presentation/controllers/static_maps_provider.dart';
import 'package:pointz/common/presentation/controllers/points_in_map_favorite_points_provider.dart';

import '../../../features/points_in_map/domain/entities/point/marker_point_model.dart';
import '../../../features/points_in_map/presentation/controllers/points_in_map_marker_creation_provider.dart';
import 'points_in_map_markers_list_provider.dart';
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
    }, (id) async {
      state = state.copyWith(isError: false, errorMessage: null, data: id);

      String title = markerPointToSave.label;
      LatLng position = LatLng(markerPointToSave.lat, markerPointToSave.lng);

      Marker markerToAddToList = Marker(
        markerId: MarkerId(id.toString()),
        infoWindow: InfoWindow(title: title),
        position: position,
      );
      bool localDbResp = await ref
          .read(localDbProvider.notifier)
          .saveMarker(markerPointToSave);
      if (localDbResp) {
        ref.read(markersListProvider.notifier).addMarker(markerToAddToList);
        await ref.read(staticMapsProvider.notifier).saveMapScreenshot(
            id: id.toString(),
            lat: markerPointToSave.lat,
            lng: markerPointToSave.lng);
        clearState();
      } else {
        state = state.copyWith(
            isError: true,
            data: null,
            errorMessage: 'Non è stato possibile salvare il marker in locale');
      }
    });
  }

  Future getMarkers() async {
    state = state.copyWith(isLoading: true);

    final resp = await _remoteApiRepository.getMarkers();

    resp.fold((exception) {
      state = state.copyWith(
          errorMessage: exception.message, isError: true, data: null);
    }, (data) async {
      List<Future> mapSnapshotsToGet = [];
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
      for (MarkerPoint markerPoint in markerPointsToBeConverted) {
        mapSnapshotsToGet.add(ref
            .read(staticMapsProvider.notifier)
            .getMapScreenshot(markerPoint.id.toString()));
      }
      await Future.wait(mapSnapshotsToGet);
      clearState();
    });
  }

  Future deleteMarker(String id) async {
    state = state.copyWith(isLoading: true);
    final resp = await _remoteApiRepository.deleteMarker(id);

    resp.fold((exception) {
      state = state.copyWith(
          errorMessage: exception.message, isError: true, data: null);
    }, (success) async {
      state = state.copyWith(isError: false, errorMessage: null, data: success);
      bool localDbResp =
          await ref.read(localDbProvider.notifier).deleteMarker(int.parse(id));
      if (localDbResp) {
        ref.read(markersListProvider.notifier).removeMarkerById(id);
        ref.read(favoritesListProvider.notifier).removeFavorite(id);
        await ref.read(staticMapsProvider.notifier).deleteMapScreenshot(id);
        clearState();
      } else {
        state = state.copyWith(
            isError: true,
            data: null,
            errorMessage:
                'Non è stato possibile cancellare il marker in locale');
      }
    });
  }

  Future updateMarker(MarkerPoint markerPoint) async {
    state = state.copyWith(isLoading: true);
    final resp =
        await _remoteApiRepository.updateMarker(markerPoint.id!, markerPoint);

    resp.fold((exception) {
      state = state.copyWith(
          errorMessage: exception.message, isError: true, data: null);
    }, (data) async {
      state = state.copyWith(isError: false, errorMessage: null, data: data);
      MarkerPoint markerPointToBeConverted = state.data;
      String id = markerPointToBeConverted.id.toString();
      String title = markerPointToBeConverted.label;
      LatLng position =
          LatLng(markerPointToBeConverted.lat, markerPointToBeConverted.lng);

      bool localDbResp =
          await ref.read(localDbProvider.notifier).updateMarker(data);
      if (localDbResp) {
        Marker mapMarkerToUpdate = Marker(
          markerId: MarkerId(id),
          infoWindow: InfoWindow(title: title),
          position: position,
        );
        ref.read(markersListProvider.notifier).addMarker(mapMarkerToUpdate);
        clearState();
      } else {
        state = state.copyWith(
            isError: true,
            data: null,
            errorMessage:
                'Non è stato possibile aggiornare il marker in locale');
      }
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
    clearState();
  }

  void clearState() {
    state = const NetworkRequestState();
  }
}

final remoteApiProvider =
    NotifierProvider<RemoteApiNotifier, NetworkRequestState>(
        () => RemoteApiNotifier());
