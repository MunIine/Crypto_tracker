import 'dart:async';

import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:coins_list/repositories/favorites/favorites.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_coins_all_event.dart';
part 'crypto_coins_all_state.dart';

class CryptoCoinsAllBloc extends Bloc<CryptoCoinsAllEvent, CryptoCoinsAllState> {
  CryptoCoinsAllBloc(this.coinsRepository, this.favoritesRepository) : super(CryptoCoinsAllInitial()) {
    on<LoadCryptoCoinsAll>((event, emit) async{
      try{
        if (state is! CryptoCoinsAllLoaded){
        emit(CryptoCoinsAllLoading());
        }
        await coinsRepository.getAllCoinsList();
        emit(CryptoCoinsAllLoaded());
      }catch (e, st) {
        emit(CryptoCoinsAllLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
    });

    on<SearchCryptoCoin>((event, emit) async{
      try {
        emit(SearchCryptoCoinLoading());
        final coinsList = await coinsRepository.getCoinFromSearch(event.coinName);
        final favorites = await favoritesRepository.getFavorites();
        emit(SearchCryptoCoinLoaded(
          coinsList: coinsList,
          favoritesList: _getFavoritesList(coinsList, favorites)
        ));
      } catch (e, st) {
        emit(SearchCryptoCoinLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
    });

    on<AddOrRemoveFavorite>((event, emit) async{
      try {
        final prevState = state;
        if (prevState is! SearchCryptoCoinLoaded){
          return;
        }
        final favorites = await favoritesRepository.addOrRemoveFavorite(event.coinName);
        emit(prevState.copyWith(
          favoritesList: _getFavoritesList(
            prevState.coinsList, 
            favorites
          )
        ));
      } catch (e, st) {
        emit(SearchCryptoCoinLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
      finally{
        event.completer?.complete();
      }
    });

    on<LoadRecommendedCoins>((event, emit) async{
      try {
        emit(SearchCryptoCoinLoading());
        final coinsList = await coinsRepository.getRecommendedCoins();
        final favorites = await favoritesRepository.getFavorites();
        emit(SearchCryptoCoinLoaded(
          favoritesList: _getFavoritesList(coinsList, favorites), 
          coinsList: coinsList
        ));
      } catch (e, st) {
        emit(SearchCryptoCoinLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
    });
  }

  List<bool> _getFavoritesList(List<CryptoCoin> coinsList, Favorite favorites){
    List<bool> favoritesList = [];
    for (var e in coinsList){
      favorites.coinNames.contains(e.name) ? favoritesList.add(true) : favoritesList.add(false);
    }
    return favoritesList;
  }

  final AbstractCoinsRepository coinsRepository;
  final AbstractFavoritesRepository favoritesRepository;
}
