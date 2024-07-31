part of 'crypto_coins_all_bloc.dart';

abstract class CryptoCoinsAllEvent extends Equatable{}

class LoadCryptoCoinsAll extends CryptoCoinsAllEvent{
  @override
  List<Object?> get props => [];
}

class SearchCryptoCoin extends CryptoCoinsAllEvent{
  SearchCryptoCoin({
    required this.coinName, 
  });

  final String coinName;

  @override
  List<Object?> get props => [coinName];
}