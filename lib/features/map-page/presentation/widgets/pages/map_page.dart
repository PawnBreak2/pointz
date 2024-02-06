import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/common/widgets/scaffolds/main_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/bottom_sheet.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GlobalKey mapWidgetKey = GlobalKey();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(41.125278, 16.866667),
    zoom: 14.4746,
  );

  onLongPress(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    var tapPosition = await controller.getScreenCoordinate(latLng);
    RenderBox mapWidgetRenderBox =
        mapWidgetKey.currentContext!.findRenderObject() as RenderBox;
    var mapWidgetPosition = mapWidgetRenderBox.localToGlobal(Offset.zero);
    print(tapPosition);

    double tapPositionX = tapPosition.x.toDouble() + mapWidgetPosition.dx;
    double tapPositionY = tapPosition.y.toDouble() + mapWidgetPosition.dy;

    if (context.mounted) {
      showModalBottomSheet(
          context: context, // This is the context before the async gap
          builder: (BuildContext context) {
            // This is a new context valid for the modal bottom sheet
            return BottomSheetForMapScreen();
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 100.h,
          child: GoogleMap(
            key: mapWidgetKey,
            mapType: MapType.hybrid,
            initialCameraPosition: initialPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onLongPress: onLongPress,
            markers: {
              const Marker(
                markerId: MarkerId('1'),
                position: LatLng(41.125278, 16.866667),
                infoWindow: InfoWindow(title: 'Bari'),
                icon: BitmapDescriptor.defaultMarker,
              ),
            },
          ),
        ),
      ),
    );
  }
}

// create a marker
Marker marker = const Marker(
  markerId: MarkerId('1'),
  position: LatLng(41.125278, 16.866667),
  infoWindow: InfoWindow(title: 'Bari'),
  icon: BitmapDescriptor.defaultMarker,
);
