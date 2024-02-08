import 'package:dartz/dartz.dart';
import 'package:pointz/common/data/data_sources/local/local_favorites_db_data_source.dart';

class LocalFavoritesDbRepository {
  final LocalFavoritesDbDataSource _localFavoritesDbDataSource;

  LocalFavoritesDbRepository({required localFavoritesDbDataSource})
      : _localFavoritesDbDataSource = localFavoritesDbDataSource;

  Future<bool> addFavorite(String favoriteValue) async {
    return _localFavoritesDbDataSource.addFavorite(favoriteValue);
  }

  Future<bool> removeFavorite(String favoriteValue) async {
    return _localFavoritesDbDataSource.removeFavorite(favoriteValue);
  }

  Future<Either<bool, List<String>>> getAllFavorites() async {
    final result = await _localFavoritesDbDataSource.getAllFavorites();
    return result.fold(
      (error) => const Left(false),
      (list) => Right(list),
    );
  }
}
