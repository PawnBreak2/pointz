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
    // initialPosition = ref.read(userInitialPosition);

    initialPosition = CameraPosition(
      target: const LatLng(41.117143, 16.871871),
      zoom: MapPageConstants.defaultZoomLevel,
    );
  }

  void onLongPress(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;

    double previousZoomLevel = await controller.getZoomLevel();

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: latLng, zoom: MapPageConstants.defaultZoomLevel * 1.05)));

    if (context.mounted) {
      showModalBottomSheet(
          context: context, // This is the context before the async gap
          builder: (BuildContext context) {
            // This is a new context valid for the modal bottom sheet
            return BottomSheetForCreatingPoints(latLng: latLng);
          }).whenComplete(() {
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: previousZoomLevel)));
        ref.invalidate(markerPointCreationProvider);
      });
    }
  }

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
    final GoogleMapController controller = await _controller.future;

    double previousZoomLevel = await controller.getZoomLevel();

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: latLng, zoom: MapPageConstants.defaultZoomLevel * 1.05)));

    if (context.mounted) {
      showModalBottomSheet(
          context: context, // This is the context before the async gap
          builder: (BuildContext context) {
            // This is a new context valid for the modal bottom sheet
            return BottomSheetForPointsDetail(latLng: latLng);
          }).whenComplete(() {
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: previousZoomLevel)));
        ref.invalidate(markerPointDetailProvider);
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
                mapType: MapType.normal,
                initialCameraPosition: initialPosition,
                onMapCreated: (GoogleMapController controller) {
                  print('Map created');
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
