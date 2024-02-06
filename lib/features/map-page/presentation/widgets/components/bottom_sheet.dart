import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/features/map-page/presentation/controllers/marker_creation_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BottomSheetForMapScreen extends ConsumerStatefulWidget {
  const BottomSheetForMapScreen({
    required this.latLng,
    super.key,
  });

  final LatLng latLng;

  @override
  ConsumerState<BottomSheetForMapScreen> createState() =>
      _BottomSheetForMapScreenState();
}

class _BottomSheetForMapScreenState
    extends ConsumerState<BottomSheetForMapScreen> {
  late TextEditingController _controller;
  late double lat;
  late double lng;

  @override
  void initState() {
    lat = widget.latLng.latitude;
    lng = widget.latLng.longitude;
    _controller = TextEditingController()
      ..addListener(() {
        ref
            .read(markerPointCreationProvider.notifier)
            .setLabel(_controller.text);
      });
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      ref.read(markerPointCreationProvider.notifier).setLatAndLng(lat, lng);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 100.w,
      child: Column(
        children: [
          const Expanded(flex: 1, child: SizedBox()),
          const Expanded(flex: 3, child: Text('Come si chiama questo posto?')),
          Expanded(
            flex: 5,
            child: TextField(controller: _controller),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
                onTap: () {
                  context.pop(); // Uses the context provided to the builder
                },
                child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(markerPointCreationProvider.notifier)
                        .addMarkerToList();
                    context.pop();
                  },
                  child: const Text('Salva'),
                )),
          ),
          const Expanded(flex: 2, child: SizedBox()),
        ],
      ),
    );
  }
}
