import 'package:coins_list/config/config.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'crypto_coins_all.g.dart';

@HiveType(typeId: CRYPTO_COIN_ALL_ID)
class CryptoCoinsAll extends Equatable{
  const CryptoCoinsAll({
    required this.symbolToName, 
    required this.nameToSymbol
  });

  @HiveField(0)
  final Map<String, String> symbolToName;

  //Value is List with 1 element or more
  @HiveField(1)
  final Map<String, List<String>> nameToSymbol;
  
  @override
  List<Object?> get props => [symbolToName, nameToSymbol];
}