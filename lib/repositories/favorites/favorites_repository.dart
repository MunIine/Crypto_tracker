import 'package:coins_list/repositories/favorites/favorites.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesRepository implements AbstractFavoritesRepository{
  FavoritesRepository({required this.favoritesBox});

  final Box<Favorite> favoritesBox;

  @override
  Future<Favorite> addOrRemoveFavorite(String coinName) async{
    Favorite favorites = favoritesBox.get("Favorites") ?? Favorite(coinNames: []);
    if(favorites.coinNames.contains(coinName)){
      favorites.coinNames.remove(coinName);
    }else{
      favorites.coinNames.add(coinName);
    }
    favoritesBox.put("Favorites", favorites);
    return favorites;
  }
  
  @override
  Future<Favorite> getFavorites() async{
    return favoritesBox.get("Favorites") ?? Favorite(coinNames: []);
  }
}