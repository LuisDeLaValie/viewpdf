// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_libros.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLibrosAdapter extends TypeAdapter<HiveLibros> {
  @override
  final int typeId = 0;

  @override
  HiveLibros read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLibros()
      ..titulo = fields[0] == null ? '' : fields[0] as String
      ..path = fields[1] == null ? '' : fields[1] as String
      ..page = fields[2] == null ? 0 : fields[2] as int
      ..zoom = fields[3] == null ? 1 : fields[3] as double
      ..isTemporal = fields[4] == null ? true : fields[4] as bool
      ..actualizado = fields[5] as DateTime
      ..creado = fields[6] as DateTime;
  }

  @override
  void write(BinaryWriter writer, HiveLibros obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.titulo)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.page)
      ..writeByte(3)
      ..write(obj.zoom)
      ..writeByte(4)
      ..write(obj.isTemporal)
      ..writeByte(5)
      ..write(obj.actualizado)
      ..writeByte(6)
      ..write(obj.creado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLibrosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
