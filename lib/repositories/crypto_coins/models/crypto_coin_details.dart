import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "crypto_coin_details.g.dart";

@JsonSerializable()
class CryptoCoinDetails extends Equatable{
  const CryptoCoinDetails({
    required this.priceInUSD,
    required this.imageURL,
    required this.high24Hours,
    required this.low24Hours
  });

  @JsonKey(name: "PRICE")
  final num priceInUSD;

  @JsonKey(name: "IMAGEURL")
  final String imageURL;

  @JsonKey(name: "HIGH24HOUR")
  final num high24Hours;

  @JsonKey(name: "LOW24HOUR")
  final num low24Hours;

  get fullImageURL => "https://www.cryptocompare.com$imageURL";

  factory CryptoCoinDetails.fromJson(Map<String, dynamic> json) => _$CryptoCoinDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoCoinDetailsToJson(this);

  @override
  List<Object?> get props => [priceInUSD, imageURL, high24Hours, low24Hours];

}