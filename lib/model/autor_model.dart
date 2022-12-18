import 'package:hive/hive.dart';

part 'autor_model.g.dart';
part '../db/autor_db.dart';

@HiveType(typeId: 4)
class AutorModel extends HiveObject {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final String nombre;

  AutorModel(this.key, this.nombre);
  factory AutorModel.fromApi(Map<String, dynamic> data) {
    return AutorModel(
      data["key"],
      data["nombre"],
    );
  }
  @override
  Future<void> save() {
    if (box != null) {
      return box!.put(key, this);
    } else {
      return AutorDB.getBox().put(key, this);
    }
  }
}
