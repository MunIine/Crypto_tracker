// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coins_all.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CryptoCoinsAllAdapter extends TypeAdapter<CryptoCoinsAll> {
  @override
  final int typeId = 3;

  @override
  CryptoCoinsAll read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CryptoCoinsAll(
      symbolToName: (fields[0] as Map).cast<String, String>(),
      nameToSymbol: (fields[1] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
    );
  }

  @override
  void write(BinaryWriter writer, CryptoCoinsAll obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.symbolToName)
      ..writeByte(1)
      ..write(obj.nameToSymbol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoCoinsAllAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
