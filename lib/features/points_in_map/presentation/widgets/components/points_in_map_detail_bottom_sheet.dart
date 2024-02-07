import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/features/points_in_map/presentation/controllers/points_in_map_favorite_points_provider.dart';
import 'package:pointz/features/points_in_map/presentation/controllers/points_in_map_marker_detail_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../common/presentation/controllers/remote_api_provider.dart';
import '../../../domain/entities/point/marker_point_model.dart';
import '../../controllers/points_in_map_marker_creation_provider.dart';
import '../../controllers/points_in_map_markers_list_provider.dart';
import '../../utils/points_in_map_is_text_empty_before_saving.dart';
import '../../utils/points_in_map_strings.dart';

class BottomSheetForPointsDetail extends ConsumerStatefulWidget {
  const BottomSheetForPointsDetail({
    required this.latLng,
    super.key,
  });

  final LatLng latLng;

  @override
  ConsumerState<BottomSheetForPointsDetail> createState() =>
      _BottomSheetForMapScreenState();
}

class _BottomSheetForMapScreenState
    extends ConsumerState<BottomSheetForPointsDetail> {
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
        print('fired');
        if (_controller.text != ref.read(markerPointDetailProvider).label) {
          ref
              .read(markerPointDetailProvider.notifier)
              .setLabel(_controller.text);
        }

        if (_controller.text.isNotEmpty) {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            ref
                .read(isTextEmptyBeforeSavingProvider.notifier)
                .update((state) => false);
          });
        }
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

  void onPressedUpdateButton() async {
    if (_controller.text.isEmpty) {
      ref
          .read(isTextEmptyBeforeSavingProvider.notifier)
          .update((state) => true);
    } else {
      MarkerPoint markerPointToUpdate = ref.read(markerPointDetailProvider);

      ref
          .read(isTextEmptyBeforeSavingProvider.notifier)
          .update((state) => false);
      await ref
          .read(remoteApiProvider.notifier)
          .updateMarker(markerPointToUpdate);
      if (context.mounted) {
        context.pop();
      }
    }
  }

  void onPressedFavoriteButton(String id) async {
    ref.read(favoritesListProvider.notifier).addFavorite(id);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      width: 100.w,
      child: Column(
        children: [
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on),
                Text(widget.latLng.longitude.toString().substring(0, 7)),
                VerticalDivider(indent: 2.h, endIndent: 2.h),
                Text(widget.latLng.latitude.toString().substring(0, 7)),
              ],
            ),
          ),
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
                return Consumer(
                  builder: (context, ref, child) {
                    _controller.text =
                        ref.read(markerPointDetailProvider).label;
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
                              ? MapPageStrings.detailPlaceNameLabelEmpty
                              : MapPageStrings.detailPlaceNameLabel,
                        ),
                        controller: _controller);
                  },
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      context.pop(); // Uses the context provided to the builder
                    },
                    child: ElevatedButton(
                      onPressed: onPressedUpdateButton,
                      child: const Text('Modifica'),
                    )),
                InkWell(
                  onTap: () {
                    context.pop(); // Uses the context provided to the builder
                  },
                  child: Consumer(
                    builder: (context, ref, child) {
                      String markerIdToAddToFavorites =
                          ref.read(markerPointDetailProvider).id.toString();
                      bool isFavorite = ref.watch(favoritesListProvider).any(
                          (element) => element == markerIdToAddToFavorites);

                      return ElevatedButton(
                        onPressed: () =>
                            onPressedFavoriteButton(markerIdToAddToFavorites),
                        child: Icon(isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Expanded(flex: 2, child: SizedBox()),
        ],
      ),
    );
  }
}
