part of 'crypto_coins_all_bloc.dart';

abstract class CryptoCoinsAllState extends Equatable {}

class CryptoCoinsAllInitial extends CryptoCoinsAllState {
  @override
  List<Object?> get props => [];
}

class SearchCryptoCoinLoading extends CryptoCoinsAllState {
  @override
  List<Object?> get props => [];
}

class SearchCryptoCoinLoaded extends CryptoCoinsAllState {
  SearchCryptoCoinLoaded({
    required this.coinsList,
    required this.favoritesList
  });

  final List<CryptoCoin> coinsList;
  final List<bool> favoritesList;

  SearchCryptoCoinLoaded copyWith({
    List<CryptoCoin>? coinsList,
    List<bool>? favoritesList,
  }) {
    return SearchCryptoCoinLoaded(
      coinsList: coinsList ?? this.coinsList,
      favoritesList: favoritesList ?? this.favoritesList,
    );
  }

  @override
  List<Object?> get props => [coinsList, favoritesList];
}

class SearchCryptoCoinLoadingFailure extends CryptoCoinsAllState{
  SearchCryptoCoinLoadingFailure({this.exception});

  final Object? exception;
  
  @override
  List<Object?> get props => [exception];
}