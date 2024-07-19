
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
      final num price = dataUSD["PRICE"];
      final String imageURL = dataUSD["IMAGEURL"];
      return CryptoCoin(name: e.key, priceInUSD: price, imageURL: "https://www.cryptocompare.com$imageURL");
    }).toList();

    return cryptoCoinsList;
  }
  
  @override
  Future<CryptoCoinDetails> getCoinDetails(String coinName) async {
    final response = await dio.get(
      "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$coinName&tsyms=USD"
    );
    final data = response.data["RAW"] as Map<String, dynamic>;
    final dataUSD = data[coinName]["USD"] as Map<String, dynamic>;
    return CryptoCoinDetails(
      name: coinName, 
      priceInUSD: dataUSD["PRICE"], 
      imageURL: "https://www.cryptocompare.com${dataUSD["IMAGEURL"]}", 
      high24Hours: dataUSD["HIGH24HOUR"], 
      low24Hours: dataUSD["LOW24HOUR"]
    );
  }
}
