import 'package:hive/hive.dart';

import '../../services/file_manager.dart';
import 'hive_libreria.dart';

part 'g/hive_libros.g.dart';

@HiveType(typeId: 0)
class HiveLibros extends HiveObject {
  @HiveField(0, defaultValue: "")
  late String titulo;
  @HiveField(1, defaultValue: "")
  late String path;
  @HiveField(2, defaultValue: 0)
  late int page;
  @HiveField(3, defaultValue: 1)
  late double zoom;
  @HiveField(4, defaultValue: true)
  late bool isTemporal;
  @HiveField(5)
  late DateTime actualizado;
  @HiveField(6)
  late DateTime creado;
  // Hive fields go her

  static void open() async {
    Hive.registerAdapter(HiveLibrosAdapter());
    await Hive.openBox<HiveLibros>('Libros');
  }

  static Box<HiveLibros> mybox() => Hive.box<HiveLibros>('Libros');

  ///
  /// funciones de operacion basicas
  ///

  static Future<String> crear(String titulo, String path) async {
    var box = mybox();
    var date = DateTime.now();

    var libro = HiveLibros()
      ..titulo = titulo
      ..path = path
      ..creado = date
      ..actualizado = date;

    await box.put("${date.millisecondsSinceEpoch}", libro);

    return "${date.millisecondsSinceEpoch}";
  }

  static HiveLibros? getKey(String key) => mybox().get(key);

  static List<HiveLibros> getWhere(bool Function(HiveLibros) where) =>
      mybox().values.where(where).toList();

  static Future<void> updateWhere(bool Function(HiveLibros) where,
      Future<HiveLibros> Function(HiveLibros) update) async {
    var box = mybox();
    var libros = HiveLibros.getWhere(where);

    var updates = <dynamic, HiveLibros>{
      for (var e in libros) e.key: await update(e)
    };
    await box.putAll(updates);
  }

  Future<void> eliminar() async {
    await FileManager(path).eliminar();
    await delete();
  }

  ///
  /// funciones abazadas
  ///

  Future<void> guardar(List<String> keys) async {
    await updateWhere((p0) => keys.contains(p0.key), (p0) async {
      return p0
        ..isTemporal = false
        ..path = await FileManager(p0.path).mover(null);
    });
    var libros = getWhere((p0) => keys.contains(p0.key));

    for (var element in libros) {
      await HiveLibreria.crear(
        element.titulo,
        null,
        [element] as HiveList<HiveLibros>,
      );
    }
  }

  /* Future<int> limpiar({List<String>? keys}) async {
    var libros = LibroHive.instance.box.values
        .where((item) => item.isTemporal || (keys?.contains(item.id) ?? false))
        .toList();

    for (var item in libros) {
      var res = await ManejoarPDF().eliminarPDF(item.path);
      if (res) {
        item.delete();
      }
    }

    return libros.length;
  } */
}
