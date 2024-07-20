
import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository{
  CryptoCoinsRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
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
