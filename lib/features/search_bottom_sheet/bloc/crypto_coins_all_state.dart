part of 'crypto_coins_all_bloc.dart';

abstract class CryptoCoinsAllState extends Equatable {}

class CryptoCoinsAllInitial extends CryptoCoinsAllState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinsAllLoading extends CryptoCoinsAllState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinsAllLoaded extends CryptoCoinsAllState {
  CryptoCoinsAllLoaded({required this.cryptoCoinsAll});

  final CryptoCoinsAll cryptoCoinsAll;

  @override
  List<Object?> get props => [cryptoCoinsAll];
}

class CryptoCoinsAllLoadingFailure extends CryptoCoinsAllState{
  CryptoCoinsAllLoadingFailure({this.exception});

  final Object? exception;
  
  @override
  List<Object?> get props => [exception];
}


class SearchCryptoCoinLoading extends CryptoCoinsAllState {
  @override
  List<Object?> get props => [];
}

class SearchCryptoCoinLoaded extends CryptoCoinsAllState {
  SearchCryptoCoinLoaded({required this.coinsList});

  final List<CryptoCoin> coinsList;

  @override
  List<Object?> get props => [coinsList];
}

class SearchCryptoCoinLoadingFailure extends CryptoCoinsAllState{
  SearchCryptoCoinLoadingFailure({this.exception});

  final Object? exception;
  
  @override
  List<Object?> get props => [exception];
}