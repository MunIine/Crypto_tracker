import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_coins_all_event.dart';
part 'crypto_coins_all_state.dart';

class CryptoCoinsAllBloc extends Bloc<CryptoCoinsAllEvent, CryptoCoinsAllState> {
  CryptoCoinsAllBloc(this.coinsRepository) : super(CryptoCoinsAllInitial()) {
    on<LoadCryptoCoinsAll>((event, emit) async{
      try{
        if (state is! CryptoCoinsAllLoaded){
        emit(CryptoCoinsAllLoading());
        }
        final coinsListAll = await coinsRepository.getAllCoinsList();
        emit(CryptoCoinsAllLoaded(cryptoCoinsAll: coinsListAll));
      }catch (e, st) {
        emit(CryptoCoinsAllLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
    });

    on<SearchCryptoCoin>((event, emit) async{
      try {
        if (state is! SearchCryptoCoinLoaded){
        emit(SearchCryptoCoinLoading());
        }
        final coinsList = await coinsRepository.getCoinFromSearch(event.coinName, event.coinsAll);
        emit(SearchCryptoCoinLoaded(coinsList: coinsList));
      } catch (e, st) {
        emit(SearchCryptoCoinLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
    });
  }

  final AbstractCoinsRepository coinsRepository;
}
