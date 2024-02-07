import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesListNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }

  void addFavorite(String id) {
    state = [...state, id];
  }

  void removeFavorite(String id) {
    state = state.where((element) => element != id).toList();
  }
}

final favoritesListProvider =
    NotifierProvider<FavoritesListNotifier, List<String>>(
  () => FavoritesListNotifier(),
);
