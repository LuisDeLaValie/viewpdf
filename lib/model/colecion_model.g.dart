// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colecion_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColecionModelAdapter extends TypeAdapter<ColecionModel> {
  @override
  final int typeId = 3;

  @override
  ColecionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColecionModel()
      ..key = fields[0] as String
      ..titulo = fields[1] as String
      ..sinopsis = fields[2] as String
      ..libros = (fields[3] as HiveList?)?.castHiveList()
      ..crado = fields[4] as DateTime;
  }

  @override
  void write(BinaryWriter writer, ColecionModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.titulo)
      ..writeByte(2)
      ..write(obj.sinopsis)
      ..writeByte(3)
      ..write(obj.libros)
      ..writeByte(4)
      ..write(obj.crado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColecionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
