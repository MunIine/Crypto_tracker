
import 'package:coins_list/extensions/exception_extensions.dart';
import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository{
  CryptoCoinsRepository({
    required this.cryptoCoinsBox,
    required this.cryptoCoinsAllBox,
    required this.dio
  });

  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;
  final Box<CryptoCoinsAll> cryptoCoinsAllBox;

  var cryptoCoinsList = <CryptoCoin>[];

  @override
  Future<List<CryptoCoin>> getCoinsList(List<String> coinsName) async {
    try {
      String coinNameToResponse = "";
      for (var i in coinsName){
        coinNameToResponse += "$i,";
      }
      final response = await dio.get(
        "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$coinNameToResponse&tsyms=USD"
      );
      List<CryptoCoin> cryptoCoinsList = await _fetchCryptoCoinsListFromAPI(response);
      
      final cryptoCoinsMap = {for (var el in cryptoCoinsList) el.name: el};
      await cryptoCoinsBox.putAll(cryptoCoinsMap);
      
      return cryptoCoinsList;
    } on Exception catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      cryptoCoinsList = cryptoCoinsBox.values.toList();
    }

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

  @override
  Future<void> getAllCoinsList() async{
    final response = await dio.get(
      "https://min-api.cryptocompare.com/data/all/coinlist"
    );
    final data = response.data["Data"] as Map<String, dynamic>;
    final Map<String, String> symbolToName = {};
    final Map<String, List<String>> nameToSymbol = {};

    for (var e in data.entries) {
      if (e.value["IsTrading"]){
        final symbol = e.key;
        final name = e.value["CoinName"].toLowerCase();
        symbolToName[symbol] = name;
        nameToSymbol.update(name, (value){
          value.add(symbol);
          return value;
        }, ifAbsent: () => [symbol]);
      }
    }
    cryptoCoinsAllBox.put("cryptoCoinsAll", CryptoCoinsAll(symbolToName: symbolToName, nameToSymbol: nameToSymbol));
  }
  
  @override
  Future<List<CryptoCoin>> getCoinFromSearch(String coinName) async{
    coinName = coinName.trim().toLowerCase();

    final coinsAll = cryptoCoinsAllBox.get("cryptoCoinsAll")!;

    final nameToSymbol = coinsAll.nameToSymbol;
    String coinNameFromMap = "";
    if (!coinsAll.symbolToName.keys.contains(coinName.toUpperCase())) {
      final namesList = nameToSymbol[coinName];
      if (namesList == null) throw(CoinNotFoundException());
      for (var i in namesList){
        coinNameFromMap += "$i,";
      }
    }else {
      coinNameFromMap = coinName;
    }

    final response = await dio.get(
      "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=${coinNameFromMap.toString()}&tsyms=USD"
    );
    final responseData = response.data as Map;

    throwIf(responseData.containsValue("Error"), CoinNotFoundException());
    return await _fetchCryptoCoinsListFromAPI(response);
  }
  
  @override
  Future<List<CryptoCoin>> getRecommendedCoins() async{
    final response = await dio.get("https://min-api.cryptocompare.com/data/top/mktcapfull?limit=100&tsym=USD");
    final responseData = response.data["Data"];
    List<CryptoCoin> coinsList = [];
    for (var el in responseData){
      try {
        final name = el["CoinInfo"]["Name"];
        final details = CryptoCoinDetails.fromJson(el["RAW"]["USD"]);
        coinsList.add(CryptoCoin(name: name, details: details));
      } on NoSuchMethodError{
        continue;
      }
    }
    return coinsList;
  }

  Future<List<CryptoCoin>> _fetchCryptoCoinsListFromAPI(Response<dynamic> response) async {
    final data = response.data["RAW"] as Map<String, dynamic>;
    final cryptoCoinsList = data.entries.map((e) {
      final dataUSD = (e.value as Map<String, dynamic>)["USD"] as Map<String, dynamic>;
      return CryptoCoin(name: e.key, details: CryptoCoinDetails.fromJson(dataUSD));
    }).toList();
    return cryptoCoinsList;
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