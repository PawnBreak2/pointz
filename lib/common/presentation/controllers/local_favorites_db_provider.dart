import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pointz/common/data/repositories/local_favorites_db_repository.dart';
import 'package:pointz/features/points_in_map/presentation/controllers/points_in_map_favorite_points_provider.dart';
import '../../data/data_sources/local/local_favorites_db_data_source.dart';
import '../../domain/models/states/local_db_request_state/core_local_db_request_state_model.dart';

class LocalFavoritesNotifier extends Notifier<LocalDbRequestState> {
  @override
  LocalDbRequestState build() {
    return const LocalDbRequestState();
  }

  final LocalFavoritesDbRepository _localFavoritesDbRepository =
      LocalFavoritesDbRepository(
          localFavoritesDbDataSource: LocalFavoritesDbDataSource());

  Future<bool> addFavorite(String favoriteValue) async {
    state = state.copyWith(isLoading: true);
    final success =
        await _localFavoritesDbRepository.addFavorite(favoriteValue);

    if (success) {
      state = state.copyWith(isLoading: false, isError: false);
      return true;
    } else {
      state = state.copyWith(isLoading: false, isError: true, data: null);
      return false;
    }
  }

  Future<bool> removeFavorite(String favoriteValue) async {
    state = state.copyWith(isLoading: true);
    final success =
        await _localFavoritesDbRepository.removeFavorite(favoriteValue);

    if (success) {
      state = state.copyWith(isLoading: false, isError: false);
      return true;
    } else {
      state = state.copyWith(isLoading: false, isError: true, data: null);
      return false;
    }
  }

  Future<void> getFavorites() async {
    state = state.copyWith(isLoading: true);

    final result = await _localFavoritesDbRepository.getAllFavorites();
    result.fold(
        (isFailure) =>
            state = state.copyWith(isLoading: false, isError: true, data: null),
        (data) {
      state = state.copyWith(isLoading: false, isError: false, data: data);
      print('gotfavorites from local db');
      print('data');
      print(data);
      ref.read(favoritesListProvider.notifier).setAllFavorites(data);
    });
  }
}

final localFavoritesProvider =
    NotifierProvider<LocalFavoritesNotifier, LocalDbRequestState>(
        () => LocalFavoritesNotifier());
