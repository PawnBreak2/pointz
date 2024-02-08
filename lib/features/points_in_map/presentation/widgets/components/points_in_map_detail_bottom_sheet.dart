import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/features/points_in_map/presentation/controllers/points_in_map_favorite_points_provider.dart';
import 'package:pointz/features/points_in_map/presentation/controllers/points_in_map_marker_detail_provider.dart';
import 'package:pointz/features/points_in_map/presentation/utils/points_in_map_is_text_equal_during_updating.dart';
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
    required this.label,
    super.key,
  });

  final LatLng latLng;
  final String label;

  @override
  ConsumerState<BottomSheetForPointsDetail> createState() =>
      _BottomSheetForMapScreenState();
}

class _BottomSheetForMapScreenState
    extends ConsumerState<BottomSheetForPointsDetail> {
  late TextEditingController _controller;
  late double lat;
  late double lng;

  @override
  void initState() {
    lat = widget.latLng.latitude;
    lng = widget.latLng.longitude;

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      ref.read(markerPointCreationProvider.notifier).setLatAndLng(lat, lng);
    });

    ///TODO: move in method

    _controller = TextEditingController()
      ..addListener(() {
        if (_controller.text != ref.read(markerPointDetailProvider).label) {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            ref
                .read(markerPointDetailProvider.notifier)
                .setLabel(_controller.text);
          });
        }
        if (_controller.text.isNotEmpty) {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            ref
                .read(isTextEmptyBeforeSavingProvider.notifier)
                .update((state) => false);
          });
        }
        if (_controller.text != widget.label) {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
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
    } else if (_controller.text == widget.label) {
      ref
          .read(isTextEqualDuringUpdateProvider.notifier)
          .update((state) => true);
      return;
    } else {
      MarkerPoint markerPointToUpdate = ref.read(markerPointDetailProvider);

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
                    Icon(Icons.location_on),
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
                      _controller.text =
                          ref.read(markerPointDetailProvider).label;
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
                                    ? TextStyle(color: Colors.blueGrey)
                                    : null,
                                focusedBorder: (isTextEmptyBeforeSaving ||
                                        isTextEqualDuringUpdate)
                                    ? Theme.of(context)
                                        .inputDecorationTheme
                                        .enabledBorder!
                                        .copyWith(
                                            borderSide:
                                                BorderSide(color: Colors.red))
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
                              String markerIdToAddToFavorites = ref
                                  .read(markerPointDetailProvider)
                                  .id
                                  .toString();
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
                                String markerIdToDelete = ref
                                    .read(markerPointDetailProvider)
                                    .id
                                    .toString();
                                onPressedDeleteButton(markerIdToDelete);
                              },
                              child: Icon(Icons.delete_forever_rounded),
                            )),
                      ],
                    )
                  : SizedBox(),
            ),
            const Expanded(flex: 2, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
