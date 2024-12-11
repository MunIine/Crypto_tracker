import 'package:coins_list/repositories/crypto_coins/models/models.dart';
import 'package:coins_list/repositories/favorites/favorites.dart';

abstract class AbstractFavoritesRepository{
  Future<Favorite> addOrRemoveFavorite(CryptoCoin coin);
  Future<Favorite> getFavorites();
  Future<void> reorderFavorites(int oldIndex, int newIndex);
}