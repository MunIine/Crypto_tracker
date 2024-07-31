part of 'crypto_coins_all_bloc.dart';

abstract class CryptoCoinsAllEvent extends Equatable{}

class LoadCryptoCoinsAll extends CryptoCoinsAllEvent{
  @override
  List<Object?> get props => [];
}

class SearchCryptoCoin extends CryptoCoinsAllEvent{
  SearchCryptoCoin({
    required this.coinName, 
    required this.coinsAll
  });

  final String coinName;
  final CryptoCoinsAll coinsAll;

  @override
  List<Object?> get props => [coinName, coinsAll];
}