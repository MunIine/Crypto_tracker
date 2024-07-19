import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';

abstract class AbstractCoinsRepository{
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoinDetails> getCoinDetails(String coinName);
}