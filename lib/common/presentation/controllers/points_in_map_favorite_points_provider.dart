import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pointz/common/presentation/controllers/local_favorites_db_provider.dart';

class FavoritesListNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }

  void addFavorite(String id) {
    state = [...state, id];
    ref.read(localFavoritesProvider.notifier).addFavorite(id);
  }

  void removeFavorite(String id) {
    state = state.where((element) => element != id).toList();
    ref.read(localFavoritesProvider.notifier).removeFavorite(id);
  }

  void setAllFavorites(List<String> favorites) {
    state = favorites;
  }

  bool checkIfFavorite(String id) {
    return state.contains(id);
  }
}

/// Stores a list of keys of the favorite markers.

final favoritesListProvider =
    NotifierProvider<FavoritesListNotifier, List<String>>(
  () => FavoritesListNotifier(),
);
