import 'package:coins_list/config/config.dart';
import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'crypto_coin.g.dart';

@HiveType(typeId: CRYPTO_COIN_ID)
class CryptoCoin extends Equatable{
  const CryptoCoin({
    required this.name,
    required this.details
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final CryptoCoinDetails details;
  
  @override
  List<Object?> get props => [name, details];
}
