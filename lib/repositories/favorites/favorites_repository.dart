import 'package:coins_list/repositories/favorites/favorites.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesRepository implements AbstractFavoritesRepository{
  FavoritesRepository({required this.favoritesBox});

  final Box<Favorite> favoritesBox;

  @override
  Future<Favorite> addOrRemoveFavorite(String coinName) async{
    // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
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
    // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
    return favoritesBox.get("Favorites") ?? Favorite(coinNames: []);
  }
}