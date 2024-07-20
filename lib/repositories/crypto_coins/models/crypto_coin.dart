import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable{
  const CryptoCoin({
    required this.name,
    required this.details
  });

  final String name;
  final CryptoCoinDetails details;
  
  @override
  List<Object?> get props => [name, details];
}
