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

class AddOrRemoveFavorite extends CryptoCoinsAllEvent{
  AddOrRemoveFavorite({
    required this.coin,
    this.completer
  });

  final CryptoCoin coin;
  final Completer? completer;

  @override
  List<Object?> get props => [coin, completer];
}

class LoadRecommendedCoins extends CryptoCoinsAllEvent{
  @override
  List<Object?> get props => [];
}