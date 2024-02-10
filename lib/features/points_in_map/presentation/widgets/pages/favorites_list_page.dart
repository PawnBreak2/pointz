import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/common/presentation/widgets/scaffolds/opaque_scaffold.dart';
import 'package:pointz/common/presentation/controllers/points_in_map_favorite_points_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../common/presentation/controllers/points_in_map_markers_list_provider.dart';

class PointsListPage extends ConsumerWidget {
  const PointsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> favoriteMarkersKeyList = ref.read(favoritesListProvider);
    List<Marker> favoriteMarkersList = ref
        .watch(markersListProvider)
        .toList()
        .where((element) =>
            favoriteMarkersKeyList.contains(element.markerId.value))
        .toList();
    bool isFavoriteListEmpty = favoriteMarkersList.isEmpty;
    return OpaqueScaffold(
        title: 'I tuoi punti preferiti',
        body: isFavoriteListEmpty
            ? const Center(
                child: Text(
                  'Non hai ancora selezionato nessun punto come preferito.',
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.separated(
                itemCount: favoriteMarkersList.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  String label =
                      favoriteMarkersList[index].infoWindow.title ?? '';
                  String lat = favoriteMarkersList[index]
                      .position
                      .latitude
                      .toString()
                      .substring(0, 7);
                  String lng = favoriteMarkersList[index]
                      .position
                      .longitude
                      .toString()
                      .substring(0, 7);
                  return ListTile(
                    title: Text(label,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    subtitle: Text('Latitudine: $lat\nLongitudine: $lng'),
                  );
                },
              ));
  }
}
