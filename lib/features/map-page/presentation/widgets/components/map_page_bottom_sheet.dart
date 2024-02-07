import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/features/map-page/presentation/controllers/marker_creation_provider.dart';
import 'package:pointz/features/map-page/presentation/controllers/markers_list_provider.dart';
import 'package:pointz/features/map-page/presentation/utils/map_page_strings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controllers/remote_api_provider.dart';
import '../../utils/map_page_is_text_empty_before_saving.dart';

class BottomSheetForMapPage extends ConsumerStatefulWidget {
  const BottomSheetForMapPage({
    required this.latLng,
    super.key,
  });

  final LatLng latLng;

  @override
  ConsumerState<BottomSheetForMapPage> createState() =>
      _BottomSheetForMapScreenState();
}

class _BottomSheetForMapScreenState
    extends ConsumerState<BottomSheetForMapPage> {
  late TextEditingController _controller;
  late double lat;
  late double lng;
  late FocusNode _focusNode;

  @override
  void initState() {
    lat = widget.latLng.latitude;
    lng = widget.latLng.longitude;
    _focusNode = FocusNode();
    _focusNode.requestFocus();

    ///TODO: move in method

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
    _focusNode.dispose();
    super.dispose();
  }

  void onPressedSaveButton() async {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (_controller.text.isEmpty) {
        ref
            .read(isTextEmptyBeforeSavingProvider.notifier)
            .update((state) => true);
      } else {
        ref
            .read(isTextEmptyBeforeSavingProvider.notifier)
            .update((state) => false);
        ref.read(remoteApiProvider.notifier).saveMarker();
        print(ref.read(markersListProvider));
        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 100.w,
      child: Column(
        children: [
          const Expanded(flex: 1, child: SizedBox()),
          const Expanded(flex: 3, child: Text('Come si chiama questo luogo?')),
          Expanded(
            flex: 5,
            child: Consumer(
              builder: (context, ref, child) {
                if (_controller.text.isNotEmpty) {
                  ref
                      .read(isTextEmptyBeforeSavingProvider.notifier)
                      .update((state) => false);
                }
                bool isTextEmptyBeforeSaving =
                    ref.watch(isTextEmptyBeforeSavingProvider);
                return TextField(
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      labelStyle: isTextEmptyBeforeSaving
                          ? TextStyle(color: Colors.blueGrey)
                          : null,
                      focusedBorder: isTextEmptyBeforeSaving
                          ? Theme.of(context)
                              .inputDecorationTheme
                              .enabledBorder!
                              .copyWith(
                                  borderSide: BorderSide(color: Colors.red))
                          : null,
                      labelText: isTextEmptyBeforeSaving
                          ? MapPageStrings.insertPlaceNameLabelEmpty
                          : MapPageStrings.insertPlaceNameLabel,
                    ),
                    controller: _controller);
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
                onTap: () {
                  context.pop(); // Uses the context provided to the builder
                },
                child: ElevatedButton(
                  onPressed: onPressedSaveButton,
                  child: const Text('Salva'),
                )),
          ),
          const Expanded(flex: 2, child: SizedBox()),
        ],
      ),
    );
  }
}
