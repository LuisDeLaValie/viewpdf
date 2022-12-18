// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libros_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LibrosModelAdapter extends TypeAdapter<LibrosModel> {
  @override
  final int typeId = 0;

  @override
  LibrosModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LibrosModel()
      ..key = fields[0] as String?
      ..titulo = fields[1] as String
      ..sinopsis = fields[2] as String?
      ..autores = (fields[3] as HiveList?)?.castHiveList()
      ..editorail = fields[4] as String?
      ..path = fields[5] as String?
      ..paginacion = fields[6] as Paginacion?
      ..origen = fields[7] as Origen?
      ..creado = fields[8] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, LibrosModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.titulo)
      ..writeByte(2)
      ..write(obj.sinopsis)
      ..writeByte(3)
      ..write(obj.autores)
      ..writeByte(4)
      ..write(obj.editorail)
      ..writeByte(5)
      ..write(obj.path)
      ..writeByte(6)
      ..write(obj.paginacion)
      ..writeByte(7)
      ..write(obj.origen)
      ..writeByte(8)
      ..write(obj.creado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibrosModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PaginacionAdapter extends TypeAdapter<Paginacion> {
  @override
  final int typeId = 1;

  @override
  Paginacion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Paginacion(
      fields[0] as int,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Paginacion obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.to)
      ..writeByte(1)
      ..write(obj.end);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaginacionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrigenAdapter extends TypeAdapter<Origen> {
  @override
  final int typeId = 2;

  @override
  Origen read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Origen(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Origen obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrigenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
