import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pointz/features/points_in_map/domain/entities/point/marker_point_model.dart';
import 'package:pointz/features/points_in_map/presentation/controllers/points_in_map_marker_detail_provider.dart';
import 'package:pointz/features/points_in_map/presentation/widgets/components/points_in_map_detail_bottom_sheet.dart';

import 'package:pointz/features/splash-page/presentation/controllers/location_controller_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../common/presentation/controllers/is_loading_provider.dart';
import '../../../../../common/presentation/widgets/scaffolds/main_scaffold.dart';
import '../../../../splash-page/domain/entites/location.dart';
import '../../controllers/points_in_map_marker_creation_provider.dart';
import '../../controllers/points_in_map_markers_list_provider.dart';
import '../../utils/points_in_map_constants.dart';
import '../../utils/points_in_map_initial_position_provider.dart';
import '../components/points_in_map_creation_bottom_sheet.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late CameraPosition initialPosition;
  double defaultZoomLevel = MapPageConstants.defaultZoomLevel;

  @override
  void initState() {
    setInitialPosition();

    super.initState();
  }

  void setInitialPosition() {
    initialPosition = ref.read(userInitialPosition);
  }

  void onLongPress(LatLng latLng) async {
    final GoogleMapController localControllerInstance =
        await _controller.future;

    double previousZoomLevel = await localControllerInstance.getZoomLevel();

    localControllerInstance.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: latLng, zoom: MapPageConstants.defaultZoomLevel * 1.05)));

    if (context.mounted) {
      showModalBottomSheet(
          context: context, // This is the context before the async gap

          builder: (BuildContext context) {
            // This is a new context valid for the modal bottom sheet
            return BottomSheetForCreatingPoints(latLng: latLng);
          }).whenComplete(() {
        localControllerInstance.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: previousZoomLevel)));
        ref.invalidate(markerPointCreationProvider);
      });
    }
  }

  /// Shows bottom sheet with details of the marker

  void onMarkerTap(String markerId) async {
    Marker marker = ref
        .read(markersListProvider)
        .firstWhere((element) => element.markerId.value == markerId);
    LatLng latLng = marker.position;
    MarkerPoint markerPoint = MarkerPoint(
        id: int.parse(marker.markerId.value),
        label: marker.infoWindow.title!,
        lat: latLng.latitude,
        lng: latLng.longitude);
    ref
        .read(markerPointDetailProvider.notifier)
        .populateMarkerPoint(markerPoint);
    final GoogleMapController localControllerInstance =
        await _controller.future;

    double previousZoomLevel = await localControllerInstance.getZoomLevel();

    localControllerInstance.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: latLng, zoom: MapPageConstants.defaultZoomLevel * 1.05)));

    if (context.mounted) {
      showModalBottomSheet(
          context: context, // This is the context before the async gap
          builder: (BuildContext context) {
            // This is a new context valid for the modal bottom sheet
            return BottomSheetForPointsDetail(
                latLng: latLng, label: marker.infoWindow.title!);
          }).then((result) async {
        localControllerInstance.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: previousZoomLevel)));
        ref.invalidate(markerPointDetailProvider);

        // Bottom Sheet is dismissed by tapping on the background

        if (result == null) {
          localControllerInstance.hideMarkerInfoWindow(MarkerId(markerId));
        } else if (result != null && result['isUpdate'] == true) {
          await Future.delayed(const Duration(seconds: 3));
          // This is to show the marker info window for a short time after the bottom sheet is closed
          // Only for update operation
          localControllerInstance.hideMarkerInfoWindow(MarkerId(markerId));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(isLoadingProvider);
    Set<Marker> markersList = ref.watch(markersListProvider).map((e) {
      return Marker(
        markerId: e.markerId,
        position: e.position,
        onTap: () {
          onMarkerTap(e.markerId.value);
        },
        infoWindow: InfoWindow(
          title: e.infoWindow.title,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      );
    }).toSet();
    return MainScaffold(
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.bouncingBall(
                  color: Colors.black, size: 10.w),
            )
          : Container(
              height: 100.h,
              child: GoogleMap(
                mapToolbarEnabled: false,
                minMaxZoomPreference: const MinMaxZoomPreference(13, 15),
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: initialPosition,
                onMapCreated: (GoogleMapController controller) {
                  if (!_controller.isCompleted) {
                    ref
                        .read(isLoadingProvider.notifier)
                        .update((state) => true);
                    _controller.complete(controller);
                  }
                  ref.read(isLoadingProvider.notifier).update((state) => false);
                },
                onLongPress: onLongPress,
                markers: markersList,
                // ,
              ),
            ),
    );
  }
}
