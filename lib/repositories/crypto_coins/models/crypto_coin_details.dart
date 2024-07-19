import 'package:equatable/equatable.dart';

class CryptoCoinDetails extends Equatable{
  const CryptoCoinDetails({
    required this.name,
    required this.priceInUSD,
    required this.imageURL,
    required this.high24Hours,
    required this.low24Hours
  });

  final String name;
  final num priceInUSD;
  final String imageURL;
  final num high24Hours;
  final num low24Hours;


  @override
  List<Object?> get props => [name, priceInUSD, imageURL, high24Hours, low24Hours];

}