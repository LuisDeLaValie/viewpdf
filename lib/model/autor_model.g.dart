// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AutorModelAdapter extends TypeAdapter<AutorModel> {
  @override
  final int typeId = 4;

  @override
  AutorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AutorModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AutorModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.nombre);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AutorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
