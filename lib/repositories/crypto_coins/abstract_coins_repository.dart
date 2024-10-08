import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';

abstract class AbstractCoinsRepository{
  Future<List<CryptoCoin>> getCoinsList(List<String> coinsName);
  Future<CryptoCoin> getCoinDetails(String coinName);
  Future<void> getAllCoinsList();
  Future<List<CryptoCoin>> getCoinFromSearch(String coinName);
  Future<List<CryptoCoin>> getRecommendedCoins();
}