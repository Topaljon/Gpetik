// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_and_company.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KeyAndCompanyAdapter extends TypeAdapter<KeyAndCompany> {
  @override
  final int typeId = 0;

  @override
  KeyAndCompany read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KeyAndCompany(
      keyGptName: fields[0] as String,
      anyCompany: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, KeyAndCompany obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.keyGptName)
      ..writeByte(1)
      ..write(obj.anyCompany);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeyAndCompanyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
