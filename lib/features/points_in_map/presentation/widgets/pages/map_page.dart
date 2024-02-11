import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pointz/common/presentation/controllers/points_in_map_favorite_points_provider.dart';
import 'package:pointz/features/points_in_map/presentation/widgets/components/points_in_map_detail_bottom_sheet.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../common/presentation/controllers/is_loading_provider.dart';
import '../../../../../common/presentation/widgets/scaffolds/main_scaffold.dart';
import '../../controllers/points_in_map_marker_creation_provider.dart';
import '../../../../../common/presentation/controllers/points_in_map_markers_list_provider.dart';
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
  List<Marker> markersList = [];

  @override
  void initState() {
    setInitialPosition();

    super.initState();
  }

  void setInitialPosition() {
    initialPosition = ref.read(userInitialPosition);
  }

  onLongPress(LatLng latLng) async {
    final GoogleMapController localControllerInstance =
        await _controller.future;

    var previousZoomLevel = await localControllerInstance.getZoomLevel();

    localControllerInstance.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: latLng, zoom: MapPageConstants.defaultZoomLevel * 1.05)));

    if (context.mounted) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return BottomSheetForCreatingPoints(latLng: latLng);
          }).whenComplete(() async {
        await localControllerInstance.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: latLng, zoom: previousZoomLevel)));
        ref.invalidate(markerPointCreationProvider);
        setState(() {});
      });
    }
  }

  /// Shows bottom sheet with details of the marker

  void onMarkerTap(String markerId, BuildContext context) async {
    inspect(markersListProvider);
    Marker marker = ref
        .read(markersListProvider)
        .firstWhere((element) => element.markerId.value == markerId);
    LatLng latLng = marker.position;

    final GoogleMapController localControllerInstance =
        await _controller.future;

    double previousZoomLevel = await localControllerInstance.getZoomLevel();

    localControllerInstance
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: latLng, zoom: MapPageConstants.defaultZoomLevel * 1.05)))
        .whenComplete(() async {
      if (context.mounted) {
        await localControllerInstance.showMarkerInfoWindow(MarkerId(markerId));

        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return BottomSheetForPointsDetail(latLng: latLng, id: markerId);
            }).then((result) async {
          await localControllerInstance.animateCamera(
              CameraUpdate.newCameraPosition(
                  CameraPosition(target: latLng, zoom: previousZoomLevel)));
          await localControllerInstance
              .hideMarkerInfoWindow(MarkerId(markerId));
          setState(() {});
        });
      }
    });
  }

  bool shouldShowFavoriteMarker(String id) {
    return ref.watch(favoritesListProvider).contains(id);
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(isLoadingProvider);

    Set<Marker> markersList = ref.read(markersListProvider).map((e) {
      return Marker(
        markerId: e.markerId,
        position: e.position,
        onTap: () {
          onMarkerTap(e.markerId.value, context);
        },
        infoWindow: InfoWindow(
          title: e.infoWindow.title,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            shouldShowFavoriteMarker(e.markerId.value)
                ? BitmapDescriptor.hueMagenta
                : BitmapDescriptor.hueCyan),
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
