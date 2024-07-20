// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinDetails _$CryptoCoinDetailsFromJson(Map<String, dynamic> json) =>
    CryptoCoinDetails(
      priceInUSD: json['PRICE'] as num,
      imageURL: json['IMAGEURL'] as String,
      high24Hours:
          CryptoCoinDetails._decimalFromJson(json['HIGH24HOUR'] as num),
      low24Hours: CryptoCoinDetails._decimalFromJson(json['LOW24HOUR'] as num),
    );

Map<String, dynamic> _$CryptoCoinDetailsToJson(CryptoCoinDetails instance) =>
    <String, dynamic>{
      'PRICE': instance.priceInUSD,
      'IMAGEURL': instance.imageURL,
      'HIGH24HOUR': instance.high24Hours,
      'LOW24HOUR': instance.low24Hours,
    };
