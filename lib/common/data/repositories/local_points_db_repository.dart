import 'package:dartz/dartz.dart';
import 'package:pointz/common/data/data_sources/local/local_points_db_data_source.dart';
import '../../../features/points_in_map/domain/entities/point/marker_point_model.dart';

class LocalPointsDbRepository {
  final LocalPointsDbDataSource _localPointsDbDataSource;

  LocalPointsDbRepository({required localPointsDbDataSource})
      : _localPointsDbDataSource = localPointsDbDataSource;

  Future<bool> saveMarker(MarkerPoint markerPoint) async {
    return _localPointsDbDataSource.saveMarker(markerPoint.toJson());
  }

  Future<bool> saveMarkers(List<MarkerPoint> markersList) async {
    // Convert the list of MarkerPoint objects to a list of Map<String, dynamic>
    List<Map<String, dynamic>> markersJsonList =
        markersList.map((marker) => marker.toJson()).toList();
    // Call the saveMarkers method in the LocalDbDataSource with the converted list
    return await _localPointsDbDataSource.saveMarkers(markersJsonList);
  }

  Future<Either<bool, List<MarkerPoint>>> getMarkers() async {
    final result = await _localPointsDbDataSource.getMarkers();
    return result.fold(
      (error) => const Left(false),
      (list) => Right(list.map(MarkerPoint.fromJson).toList()),
    );
  }

  Future<bool> updateMarker(MarkerPoint markerPoint) async {
    return _localPointsDbDataSource.updateMarker(
        markerPoint.id!, markerPoint.toJson());
  }

  Future<bool> deleteMarker(int id) async {
    return _localPointsDbDataSource.deleteMarker(id);
  }
}
