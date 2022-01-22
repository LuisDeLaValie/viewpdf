// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PDFModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PDFModelAdapter extends TypeAdapter<PDFModel> {
  @override
  final int typeId = 1;

  @override
  PDFModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PDFModel(
      id: fields[0] as String,
      page: fields[1] as int,
      path: fields[2] as String,
      name: fields[3] as String,
      actualizado: fields[4] as DateTime,
      isTemporal: fields[5] as bool,
      zoom: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PDFModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.page)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.actualizado)
      ..writeByte(5)
      ..write(obj.isTemporal)
      ..writeByte(6)
      ..write(obj.zoom);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PDFModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
