import 'package:hive/hive.dart';

import 'hive_libros.dart';

part 'g/hive_libreria.g.dart';

@HiveType(typeId: 1)
class HiveLibreria extends HiveObject {
  @HiveField(0, defaultValue: "")
  late String titulo;
  @HiveField(1)
  String? detalles;
  @HiveField(2)
  late HiveList<HiveLibros> libros;
  @HiveField(3)
  late DateTime actualizado;
  @HiveField(4)
  late DateTime creado;

  static void open() async {
    Hive.registerAdapter(HiveLibreriaAdapter());
    await Hive.openBox<HiveLibreria>('Libreria');
  }

  static Box<HiveLibreria> mybox() => Hive.box<HiveLibreria>('Libreria');

  static Future<String> crear(
      String titulo, String? detalles, HiveList<HiveLibros> libros) async {
    var box = mybox();
    var date = DateTime.now();

    var libro = HiveLibreria()
      ..titulo = titulo
      ..detalles = detalles
      ..libros = libros
      ..creado = date
      ..actualizado = date;

    await box.put(date.toString(), libro);

    return date.toString();
  }

  static HiveLibreria? getKey(String key) => mybox().get(key);

  static List<HiveLibreria> getWhere(bool Function(HiveLibreria) where) =>
      mybox().values.where(where).toList();

  static Future<void> updateWhere(bool Function(HiveLibreria) where,
      Future<HiveLibreria> Function(HiveLibreria) update) async {
    var box = mybox();
    var libros = HiveLibreria.getWhere(where);

    var updates = <dynamic, HiveLibreria>{
      for (var e in libros) e.key: await update(e)
    };
    await box.putAll(updates);
  }

  Future<void> eliminar() async {
    for (var element in libros.toList()) {
      await HiveLibreria.crear(
          element.titulo, null, [element] as HiveList<HiveLibros>);
    }
    delete();
  }

  Future<void> borrar() async {
    for (var element in libros.toList()) {
      await element.eliminar();
    }
    delete();
  }
}
