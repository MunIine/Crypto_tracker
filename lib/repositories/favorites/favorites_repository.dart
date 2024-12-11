import 'package:coins_list/repositories/crypto_coins/models/models.dart';
import 'package:coins_list/repositories/favorites/favorites.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesRepository implements AbstractFavoritesRepository{
  FavoritesRepository({required this.cryptoCoinsBox, required this.favoritesBox});

  final Box<Favorite> favoritesBox;
  final Box<CryptoCoin> cryptoCoinsBox;

  @override
  Future<Favorite> addOrRemoveFavorite(CryptoCoin coin) async{
    // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
    Favorite favorites = favoritesBox.get("Favorites") ?? Favorite(coinNames: []);
    final coinName = coin.name;
    if(favorites.coinNames.contains(coinName)){
      favorites.coinNames.remove(coinName);
      cryptoCoinsBox.delete(coinName);
    }else{
      favorites.coinNames.add(coinName);
      cryptoCoinsBox.put(coinName, coin);
    }
    favoritesBox.put("Favorites", favorites);
    return favorites;
  }
  
  @override
  Future<Favorite> getFavorites() async{
    // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
    return favoritesBox.get("Favorites") ?? Favorite(coinNames: []);
  }
  
  @override
  Future<void> reorderFavorites(int oldIndex, int newIndex) async{
    final favorites = favoritesBox.get("Favorites")!;
    final element = favorites.coinNames.removeAt(oldIndex);
    favorites.coinNames.insert(newIndex, element);
    favoritesBox.put("Favorites", favorites);
  }
}