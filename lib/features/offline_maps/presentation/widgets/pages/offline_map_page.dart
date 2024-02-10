import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pointz/common/domain/navigation/navigation_map.dart';
import 'package:pointz/common/presentation/widgets/scaffolds/main_scaffold.dart';
import 'package:pointz/common/presentation/widgets/scaffolds/opaque_scaffold.dart';
import 'package:pointz/features/offline_maps/presentation/controllers/offline_points_provider.dart';
import 'package:pointz/features/offline_maps/presentation/controllers/selected_offline_points_provider.dart';
import 'package:pointz/features/points_in_map/domain/entities/point/marker_point_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../common/presentation/controllers/static_maps_provider.dart';

class OfflineMapPage extends ConsumerStatefulWidget {
  const OfflineMapPage({super.key});

  @override
  ConsumerState<OfflineMapPage> createState() => _OfflineMapPageState();
}

class _OfflineMapPageState extends ConsumerState<OfflineMapPage> {
  late List offlinePoints;
  @override
  void initState() {
    offlinePoints = ref.read(offlinePointsProvider);
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (offlinePoints.isNotEmpty) {
        ref
            .read(staticMapsProvider.notifier)
            .getMapScreenshot(offlinePoints[0].id.toString());
        ref
            .read(selectedOfflinePointProvider.notifier)
            .update((state) => offlinePoints[0]);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(offlinePoints);
    return OpaqueScaffold(
        isOffline: true,
        leading: IconButton(
          icon: const Icon(Icons.location_on_sharp),
          onPressed: () {
            context.pushNamed(
                NavigationMap.getPage(NavigationPage.offlinePointsList));
          },
        ),
        body: Container(
            height: 100.h,
            child: Builder(
              builder: (context) {
                MarkerPoint? selectedPoint =
                    ref.watch(selectedOfflinePointProvider);
                File? image =
                    ref.watch(staticMapsProvider.select((value) => value.data));

                if (offlinePoints.isEmpty) {
                  return const Center(child: Text('Nessun punto offline'));
                } else {
                  if (image != null) {
                    return Stack(
                      children: [
                        Image.file(image),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            color: Colors.white,
                            width: 100.w,
                            height: 10.h,
                            child: Align(
                              child: Text(
                                selectedPoint!.label,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
              },
            )));
  }
}
