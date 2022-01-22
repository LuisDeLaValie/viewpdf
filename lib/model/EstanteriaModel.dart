import 'package:hive/hive.dart';

import 'PDFModel.dart';

part 'EstanteriaModel.g.dart';

@HiveType(typeId: 2)
class EstanteriaModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String nombre;
  @HiveField(2)
  HiveList<PDFModel> libros;
  @HiveField(3)
  bool isColeection;

  EstanteriaModel({
    required this.id,
    required this.nombre,
    required this.libros,
    required this.isColeection,
  });

  @override
  String toString() {
    return 'EstanteriaModel( key: $key, libros: $libros)';
  }
}
