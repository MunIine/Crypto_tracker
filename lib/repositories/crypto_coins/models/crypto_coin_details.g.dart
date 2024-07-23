// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CryptoCoinDetailsAdapter extends TypeAdapter<CryptoCoinDetails> {
  @override
  final int typeId = 1;

  @override
  CryptoCoinDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CryptoCoinDetails(
      priceInUSD: fields[0] as num,
      imageURL: fields[1] as String,
      high24Hours: fields[2] as num,
      low24Hours: fields[3] as num,
    );
  }

  @override
  void write(BinaryWriter writer, CryptoCoinDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.priceInUSD)
      ..writeByte(1)
      ..write(obj.imageURL)
      ..writeByte(2)
      ..write(obj.high24Hours)
      ..writeByte(3)
      ..write(obj.low24Hours);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoCoinDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinDetails _$CryptoCoinDetailsFromJson(Map<String, dynamic> json) =>
    CryptoCoinDetails(
      priceInUSD: CryptoCoinDetails._decimalFromJson(json['PRICE'] as num),
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
