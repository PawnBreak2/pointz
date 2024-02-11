import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/common/presentation/controllers/points_in_map_favorite_points_provider.dart';
import 'package:pointz/features/points_in_map/presentation/utils/points_in_map_is_text_equal_during_updating.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../common/presentation/controllers/points_management_provider.dart';
import '../../../domain/entities/point/marker_point_model.dart';
import '../../../../../common/presentation/controllers/points_in_map_markers_list_provider.dart';
import '../../utils/points_in_map_is_text_empty_before_saving.dart';
import '../../utils/points_in_map_strings.dart';

class BottomSheetForPointsDetail extends ConsumerStatefulWidget {
  const BottomSheetForPointsDetail({
    required this.id,
    required this.latLng,
    super.key,
  });

  final LatLng latLng;
  final String id;

  @override
  ConsumerState<BottomSheetForPointsDetail> createState() =>
      _BottomSheetForMapScreenState();
}

class _BottomSheetForMapScreenState
    extends ConsumerState<BottomSheetForPointsDetail> {
  late TextEditingController _controller;
  late double lat;
  late double lng;
  late String label;
  @override
  void initState() {
    lat = widget.latLng.latitude;
    lng = widget.latLng.longitude;
    Marker marker = ref
        .read(markersListProvider)
        .firstWhere((element) => element.markerId.value == widget.id);

    label = marker.infoWindow.title!;

    ///TODO: move in method

    _controller = TextEditingController(text: label)
      ..addListener(() {
        if (_controller.text.isNotEmpty) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ref
                .read(isTextEmptyBeforeSavingProvider.notifier)
                .update((state) => false);
          });
        }
        if (_controller.text != label) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ref
                .read(isTextEqualDuringUpdateProvider.notifier)
                .update((state) => false);
          });
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onPressedUpdateButton() async {
    if (_controller.text.isEmpty) {
      ref
          .read(isTextEmptyBeforeSavingProvider.notifier)
          .update((state) => true);
      return;
    } else if (_controller.text == label) {
      ref
          .read(isTextEqualDuringUpdateProvider.notifier)
          .update((state) => true);
      return;
    } else {
      MarkerPoint markerPointToUpdate = MarkerPoint(
          id: int.parse(widget.id),
          label: _controller.text,
          lat: lat,
          lng: lng);

      ref
          .read(isTextEmptyBeforeSavingProvider.notifier)
          .update((state) => false);
      await ref
          .read(remoteApiProvider.notifier)
          .updateMarker(markerPointToUpdate);
      if (context.mounted) {
        context.pop({'isUpdate': true});
      }
    }
  }

  void onPressedFavoriteButton(String id) async {
    if (ref.read(favoritesListProvider.notifier).checkIfFavorite(id)) {
      ref.read(favoritesListProvider.notifier).removeFavorite(id);
    } else {
      ref.read(favoritesListProvider.notifier).addFavorite(id);
    }
  }

  void onPressedDeleteButton(String id) async {
    ref.read(remoteApiProvider.notifier).deleteMarker(id);
    context.pop({'isUpdate': false});
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: SizedBox(
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
                    const Icon(Icons.location_on),
                    Text(widget.latLng.longitude.toString().substring(0, 7)),
                    VerticalDivider(indent: 2.h, endIndent: 2.h),
                    Text(widget.latLng.latitude.toString().substring(0, 7)),
                  ],
                )),
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
                  bool isTextEqualDuringUpdate =
                      ref.watch(isTextEqualDuringUpdateProvider);
                  return Consumer(
                    builder: (context, ref, child) {
                      return Builder(builder: (context) {
                        String labelText = '';
                        if (isTextEqualDuringUpdate) {
                          labelText = MapPageStrings.detailPlaceNameLabelEqual;
                        } else if (isTextEmptyBeforeSaving) {
                          labelText = MapPageStrings.detailPlaceNameLabelEmpty;
                        } else {
                          labelText = MapPageStrings.detailPlaceNameLabel;
                        }
                        return TextField(
                            decoration: InputDecoration(
                                labelStyle: (isTextEmptyBeforeSaving ||
                                        isTextEqualDuringUpdate)
                                    ? const TextStyle(color: Colors.blueGrey)
                                    : null,
                                focusedBorder: (isTextEmptyBeforeSaving ||
                                        isTextEqualDuringUpdate)
                                    ? Theme.of(context)
                                        .inputDecorationTheme
                                        .enabledBorder!
                                        .copyWith(
                                            borderSide: const BorderSide(
                                                color: Colors.red))
                                    : null,
                                labelText: labelText),
                            controller: _controller);
                      });
                    },
                  );
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: (keyboardHeight <= 0)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              context
                                  .pop(); // Uses the context provided to the builder
                            },
                            child: ElevatedButton(
                              onPressed: onPressedUpdateButton,
                              child: const Text('Modifica'),
                            )),
                        InkWell(
                          onTap: () {
                            context
                                .pop(); // Uses the context provided to the builder
                          },
                          child: Consumer(
                            builder: (context, ref, child) {
                              String markerIdToAddToFavorites = widget.id;
                              bool isFavorite = ref
                                  .watch(favoritesListProvider)
                                  .any((element) =>
                                      element == markerIdToAddToFavorites);

                              return ElevatedButton(
                                onPressed: () => onPressedFavoriteButton(
                                    markerIdToAddToFavorites),
                                child: Icon(isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border),
                              );
                            },
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              context
                                  .pop(); // Uses the context provided to the builder
                            },
                            child: ElevatedButton(
                              onPressed: () {
                                onPressedDeleteButton(widget.id);
                              },
                              child: const Icon(Icons.delete_forever_rounded),
                            )),
                      ],
                    )
                  : const SizedBox(),
            ),
            const Expanded(flex: 2, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
