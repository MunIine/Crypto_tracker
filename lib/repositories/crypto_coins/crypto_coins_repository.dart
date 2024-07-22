
import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository{
  CryptoCoinsRepository({
    required this.cryptoCoinsBox,
    required this.dio
  });

  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;
  var cryptoCoinsList = <CryptoCoin>[];

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    try {
      List<CryptoCoin> cryptoCoinsList = await _fetchCryptoCoinsListFromAPI();
      
      final cryptoCoinsMap = {for (var el in cryptoCoinsList) el.name: el};
      await cryptoCoinsBox.putAll(cryptoCoinsMap);
      
      return cryptoCoinsList;
    } on Exception catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      cryptoCoinsList = cryptoCoinsBox.values.toList();
    }

    return cryptoCoinsList;
  }

  Future<List<CryptoCoin>> _fetchCryptoCoinsListFromAPI() async {
    final response = await dio.get(
      "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=USDT,BTC,ETH,TONCOIN,NOT,SOL,BNB&tsyms=USD"
    );
    final data = response.data["RAW"] as Map<String, dynamic>;
    final cryptoCoinsList = data.entries.map((e) {
      final dataUSD = (e.value as Map<String, dynamic>)["USD"] as Map<String, dynamic>;
      return CryptoCoin(name: e.key, details: CryptoCoinDetails.fromJson(dataUSD));
    }).toList();
    return cryptoCoinsList;
  }
  
  @override
  Future<CryptoCoin> getCoinDetails(String coinName) async {
    try {
      final coin = await _fetchCryptoCoinDetailsFromAPI(coinName);
      cryptoCoinsBox.put(coinName, coin);
      return coin;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return cryptoCoinsBox.get(coinName)!;
    }
  }

  Future<CryptoCoin> _fetchCryptoCoinDetailsFromAPI(String coinName) async {
    final response = await dio.get(
      "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$coinName&tsyms=USD"
    );
    final data = response.data["RAW"] as Map<String, dynamic>;
    final dataUSD = data[coinName]["USD"] as Map<String, dynamic>;
    return CryptoCoin(
      name: coinName, 
      details: CryptoCoinDetails.fromJson(dataUSD)
    );
  }
}
