import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pointz/common/presentation/controllers/static_maps_provider.dart';
import 'package:pointz/common/presentation/widgets/scaffolds/main_scaffold.dart';
import 'package:pointz/common/presentation/widgets/scaffolds/opaque_scaffold.dart';
import 'package:pointz/features/offline_maps/presentation/controllers/offline_points_provider.dart';
import 'package:pointz/features/offline_maps/presentation/controllers/selected_offline_points_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OfflinePointsListPage extends ConsumerWidget {
  const OfflinePointsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List offlinePoints = ref.watch(offlinePointsProvider);
    return OpaqueScaffold(
      title: 'I tuoi punti offline',
      body: ListView.builder(
          itemCount: offlinePoints.length,
          itemBuilder: (context, index) {
            int id = offlinePoints[index].id;
            return ListTile(
              title: Text(offlinePoints[index].label),
              onTap: () {
                SchedulerBinding.instance!.addPostFrameCallback((_) async {
                  await ref
                      .read(staticMapsProvider.notifier)
                      .getMapScreenshot(id.toString());
                  ref
                      .read(selectedOfflinePointProvider.notifier)
                      .update((state) => offlinePoints[index]);
                  context.pop();
                });
              },
            );
          }),
    );
  }
}
