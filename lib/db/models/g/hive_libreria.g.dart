// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_libreria.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLibreriaAdapter extends TypeAdapter<HiveLibreria> {
  @override
  final int typeId = 1;

  @override
  HiveLibreria read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLibreria()
      ..titulo = fields[0] == null ? '' : fields[0] as String
      ..detalles = fields[1] as String?
      ..libros = (fields[2] as HiveList).castHiveList()
      ..actualizado = fields[3] as DateTime
      ..creado = fields[4] as DateTime;
  }

  @override
  void write(BinaryWriter writer, HiveLibreria obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.titulo)
      ..writeByte(1)
      ..write(obj.detalles)
      ..writeByte(2)
      ..write(obj.libros)
      ..writeByte(3)
      ..write(obj.actualizado)
      ..writeByte(4)
      ..write(obj.creado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLibreriaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
