import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pointz/common/style/icons/custom_icons.dart';
import 'package:pointz/common/widgets/scaffolds/main_scaffold.dart';
import 'package:pointz/features/map-page/presentation/controllers/marker_creation_provider.dart';
import 'package:pointz/features/map-page/presentation/controllers/markers_list_provider.dart';
import 'package:pointz/features/map-page/presentation/utils/map_page_constants.dart';
import 'package:pointz/features/splash-page/presentation/controllers/location_controller_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../common/providers/is_loading_provider.dart';
import '../../../../splash-page/domain/entites/location.dart';
import '../components/map_page_bottom_sheet.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  GlobalKey mapWidgetKey = GlobalKey();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late CameraPosition initialPosition;
  double defaultZoomLevel = MapPageConstants.defaultZoomLevel;

  @override
  void initState() {
    setInitialPosition();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      // Sets loading screen until map is created
      ref.read(isLoadingProvider.notifier).update((state) => true);
    });
    super.initState();
  }

  setInitialPosition() {
    // initialPosition = ref.read(userInitialPosition);

    initialPosition = CameraPosition(
      target: const LatLng(41.117143, 16.871871),
      zoom: MapPageConstants.defaultZoomLevel,
    );
  }

  onLongPress(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    var tapPosition = await controller.getScreenCoordinate(latLng);
    RenderBox mapWidgetRenderBox =
        mapWidgetKey.currentContext!.findRenderObject() as RenderBox;
    var mapWidgetPosition = mapWidgetRenderBox.localToGlobal(Offset.zero);
    print(tapPosition);

    double tapPositionX = tapPosition.x.toDouble() + mapWidgetPosition.dx;
    double tapPositionY = tapPosition.y.toDouble() + mapWidgetPosition.dy;
    var previousZoomLevel = await controller.getZoomLevel();

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: latLng, zoom: MapPageConstants.defaultZoomLevel * 1.05)));

    if (context.mounted) {
      showModalBottomSheet(
          context: context, // This is the context before the async gap
          builder: (BuildContext context) {
            // This is a new context valid for the modal bottom sheet
            return BottomSheetForMapPage(latLng: latLng);
          }).whenComplete(() {
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: previousZoomLevel)));
        ref.invalidate(markerPointCreationProvider);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(isLoadingProvider);
    Set<Marker> markersList = ref.watch(markersListProvider);
    print('markersList: $markersList');
    print(markersList.length);
    return MainScaffold(
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.bouncingBall(
                  color: Colors.black, size: 10.w),
            )
          : Container(
              height: 100.h,
              child: GoogleMap(
                key: mapWidgetKey,
                mapType: MapType.normal,
                initialCameraPosition: initialPosition,
                onMapCreated: (GoogleMapController controller) {
                  print('Map created');
                  _controller.complete(controller);
                  ref.read(isLoadingProvider.notifier).update((state) => false);
                },
                onLongPress: onLongPress,
                markers: markersList,
              ),
            ),
    );
  }
}
