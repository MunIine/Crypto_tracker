import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_coin_state.dart';
part 'crypto_coin_event.dart';

class CryptoCoinBloc extends Bloc<CryptoCoinEvent, CryptoCoinState> {
  CryptoCoinBloc(this.coinsRepository) : super(CryptoCoinInitial()) {
    on<LoadCryptoCoin>((event, emit) async{
      try {
        emit(CryptoCoinLoading());
        final coinDetails = await coinsRepository.getCoinDetails(event.coinName);
        emit(CryptoCoinLoaded(coinDetails: coinDetails));

      } catch (e, st) {
        emit(CryptoCoinLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
    });
  }

  final AbstractCoinsRepository coinsRepository;
}