// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EstanteriaModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EstanteriaModelAdapter extends TypeAdapter<EstanteriaModel> {
  @override
  final int typeId = 2;

  @override
  EstanteriaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EstanteriaModel(
      id: fields[0] as String,
      nombre: fields[1] as String,
      libros: (fields[2] as HiveList).castHiveList(),
      isColeection: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, EstanteriaModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.libros)
      ..writeByte(3)
      ..write(obj.isColeection);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EstanteriaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
