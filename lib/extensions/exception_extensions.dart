class CoinNotFoundException implements Exception{
  @override
  String toString() {
    return "Coin not found";
  }
}