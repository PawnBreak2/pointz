import 'package:dartz/dartz.dart';
import 'package:pointz/common/data/data_sources/local/local_db_data_source.dart';
import '../../../features/points_in_map/domain/entities/point/marker_point_model.dart';

class LocalDbRepository {
  final LocalDbDataSource _localDbDataSource;

  LocalDbRepository({required localDbDataSource})
      : _localDbDataSource = localDbDataSource;

  Future<bool> saveMarker(MarkerPoint markerPoint) async {
    return _localDbDataSource.saveMarker(markerPoint.toJson());
  }

  Future<Either<bool, List<MarkerPoint>>> getMarkers() async {
    final result = await _localDbDataSource.getMarkers();
    return result.fold(
      (error) => const Left(false),
      (list) => Right(list.map(MarkerPoint.fromJson).toList()),
    );
  }

  Future<bool> updateMarker(MarkerPoint markerPoint) async {
    return _localDbDataSource.updateMarker(
        markerPoint.id!, markerPoint.toJson());
  }

  Future<bool> deleteMarker(int id) async {
    return _localDbDataSource.deleteMarker(id);
  }
}
