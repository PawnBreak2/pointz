import 'package:dartz/dartz.dart';
import 'package:pointz/common/db_service/db.dart'; // Adjust the import path as necessary
import 'package:sqflite/sqflite.dart';

class LocalPointsDbDataSource {
  Future<bool> saveMarker(Map<String, dynamic> markerPointJson) async {
    final db = await DBService.database;
    try {
      await db.insert('markerPoints', markerPointJson,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveMarkers(List<Map<String, dynamic>> markersList) async {
    final db = await DBService.database;
    return await db.transaction((txn) async {
      try {
        await txn.delete('markerPoints');

        for (var marker in markersList) {
          await txn.insert('markerPoints', marker,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
        return true; // Success
      } catch (e) {
        return false; // Something went wrong, transaction is rolled back
      }
    });
  }

  Future<Either<bool, List<Map<String, dynamic>>>> getMarkers() async {
    final db = await DBService.database;
    try {
      final maps = await db.query('markerPoints');
      if (maps.isNotEmpty) {
        return Right(maps);
      } else {
        return const Left(false);
      }
    } catch (e) {
      return const Left(false);
    }
  }

  Future<bool> updateMarker(
      int id, Map<String, dynamic> markerPointJson) async {
    final db = await DBService.database;
    markerPointJson['id'] =
        id; // Ensure the JSON contains the correct ID for the update operation
    try {
      await db.update(
        'markerPoints',
        markerPointJson,
        where: 'id = ?',
        whereArgs: [id],
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteMarker(int id) async {
    final db = await DBService.database;
    try {
      await db.delete(
        'markerPoints',
        where: 'id = ?',
        whereArgs: [id],
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
