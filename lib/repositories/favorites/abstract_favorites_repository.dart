import 'package:coins_list/repositories/favorites/favorites.dart';

abstract class AbstractFavoritesRepository{
  Future<Favorite> addOrRemoveFavorite(String coinName);
  Future<Favorite> getFavorites();
  Future<void> reorderFavorites(int oldIndex, int newIndex);
}