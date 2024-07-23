import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:coins_list/extensions/num_extensions.dart';

part "crypto_coin_details.g.dart";

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetails extends Equatable{
  const CryptoCoinDetails({
    required this.priceInUSD,
    required this.imageURL,
    required this.high24Hours,
    required this.low24Hours
  });

  @HiveField(0)
  @JsonKey(
    name: "PRICE",
    fromJson: _decimalFromJson
  )
  final num priceInUSD;

  @HiveField(1)
  @JsonKey(name: "IMAGEURL")
  final String imageURL;

  @HiveField(2)
  @JsonKey(
    name: "HIGH24HOUR",
    fromJson: _decimalFromJson
  )
  final num high24Hours;

  @HiveField(3)
  @JsonKey(
    name: "LOW24HOUR",
    fromJson: _decimalFromJson
  )
  final num low24Hours;

  get fullImageURL => "https://www.cryptocompare.com$imageURL";

  factory CryptoCoinDetails.fromJson(Map<String, dynamic> json) => _$CryptoCoinDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoCoinDetailsToJson(this);

  static num _decimalFromJson(num number) => number.cutNumber(6);

  @override
  List<Object?> get props => [priceInUSD, imageURL, high24Hours, low24Hours];
}