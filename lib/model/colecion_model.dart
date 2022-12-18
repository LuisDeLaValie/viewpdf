import 'package:hive/hive.dart';

import 'estanteria_model.dart';
import 'libros_model.dart';

part 'colecion_model.g.dart';
part '../db/colecion_db.dart';

@HiveType(typeId: 3)
class ColecionModel extends HiveObject implements EstanteriaModel {
  @HiveField(0)
  late String key;
  @HiveField(1)
  late String titulo;
  @HiveField(2)
  late String sinopsis;
  @HiveField(3)
  late HiveList<LibrosModel>? libros;
  @HiveField(4)
  late DateTime crado;

  ColecionModel();

  factory ColecionModel.fromApi(Map<String, dynamic> data) {
    return ColecionModel()
      ..key = data["key"]
      ..titulo = data["titulo"]
      ..sinopsis = data["sinopsis"]
      // ..libros = HiveList(LibrosDb.getBox(), objects: libros) // data["libros"]
      ..crado = DateTime.parse(data["creado"]);
  }

  @override
  Future<void> save() {
    if (box != null) {
      return box!.put(key, this);
    } else {
      return ColecionDb.getBox().put(key, this);
    }
  }

  // Hive fields go here
}
