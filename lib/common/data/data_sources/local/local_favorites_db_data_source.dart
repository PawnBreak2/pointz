import 'package:dartz/dartz.dart';
import 'package:pointz/common/db_service/db.dart'; // Adjust the import path as necessary
import 'package:sqflite/sqflite.dart';

class LocalFavoritesDbDataSource {
  Future<bool> addFavorite(String favoritePoint) async {
    print('addFavorite: $favoritePoint');
    final db = await DBService.database;
    try {
      await db.insert(
          'favorites',
          {
            'id': favoritePoint,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFavorite(String favoritePoint) async {
    final db = await DBService.database;
    try {
      int result = await db.delete(
        'favorites',
        where: 'id = ?',
        whereArgs: [favoritePoint],
      );
      return result > 0;
    } catch (e) {
      return false;
    }
  }

  Future<Either<bool, List<String>>> getAllFavorites() async {
    final db = await DBService.database;
    try {
      final List<Map<String, dynamic>> results = await db.query('favorites');
      List<String> favorites =
          results.map((result) => result['id'] as String).toList();
      return Right(favorites);
    } catch (e) {
      return const Left(false);
    }
  }
}
