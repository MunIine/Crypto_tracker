import 'dart:async';

import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:coins_list/repositories/favorites/favorites.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part "crypto_list_event.dart";
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository, this.favoritesRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async{
      try {
        if (state is! CryptoListLoaded){
        emit(CryptoListLoading());
        }
        final favorites = await favoritesRepository.getFavorites();
        if (favorites == const Favorite(coinNames: [])){
          emit(CryptoListInitial());
          return;
        }
        final coinsList = await coinsRepository.getCoinsList(favorites.coinNames);
        emit(CryptoListLoaded(coinsList: coinsList));
      } catch (e, st) {
        emit(CryptoListLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      } finally{
        event.completer?.complete();
      }
    });
  }

  final AbstractCoinsRepository coinsRepository;
  final AbstractFavoritesRepository favoritesRepository;
}