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
    required this.coinName,
    this.completer
  });

  final String coinName;
  final Completer? completer;

  @override
  List<Object?> get props => [coinName, completer];
}

class LoadRecommendedCoins extends CryptoCoinsAllEvent{
  @override
  List<Object?> get props => [];
}