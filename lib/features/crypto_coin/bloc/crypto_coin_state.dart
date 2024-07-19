part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinState extends Equatable{}

class CryptoCoinInitial extends CryptoCoinState{
  @override
  List<Object?> get props => [];
}

class CryptoCoinLoading extends CryptoCoinState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinLoaded extends CryptoCoinState {
  CryptoCoinLoaded({required this.coinDetails});

  final CryptoCoinDetails coinDetails;
  
  @override
  List<Object?> get props => [coinDetails];
}

class CryptoCoinLoadingFailure extends CryptoCoinState{
  CryptoCoinLoadingFailure({this.exception});

  final Object? exception;
  
  @override
  List<Object?> get props => [exception];
}