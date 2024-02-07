import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/common/presentation/widgets/scaffolds/opaque_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controllers/points_in_map_markers_list_provider.dart';

class PointsListPage extends ConsumerWidget {
  const PointsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Marker> markersList = ref.watch(markersListProvider).toList();
    return OpaqueScaffold(
        body: ListView.separated(
      itemCount: markersList.length,
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemBuilder: (context, index) {
        String label = markersList[index].infoWindow.title ?? '';
        String lat =
            markersList[index].position.latitude.toString().substring(0, 7);
        String lng =
            markersList[index].position.longitude.toString().substring(0, 7);
        return ListTile(
          title: Text(label,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          subtitle: Text('Latitudine: $lat\nLongitudine: $lng'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.edit,
                color: Colors.black,
              ),
              SizedBox(
                width: 2.w,
              ),
              Icon(
                Icons.delete_forever_rounded,
                color: Colors.black,
              ),
            ],
          ),
        );
      },
    ));
  }
}
