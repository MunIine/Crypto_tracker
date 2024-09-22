part of 'crypto_list_bloc.dart';

abstract class CryptoListEvent extends Equatable{}

class LoadCryptoList extends CryptoListEvent{
  LoadCryptoList({
    this.completer
  });

  final Completer? completer;
  
  @override
  List<Object?> get props => [completer];
}

class ReorderFavorites extends CryptoListEvent{
  ReorderFavorites({
    required this.oldIndex, 
    required this.newIndex
  });

  final int oldIndex;
  final int newIndex;

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class AddOrRemoveCoinFromList extends CryptoListEvent{
  AddOrRemoveCoinFromList({this.index, required this.coin});
  
  final CryptoCoin coin;
  final int? index;

  @override
  List<Object?> get props => [coin];
}