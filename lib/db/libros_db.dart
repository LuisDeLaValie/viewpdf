part of '../model/libros_model.dart';

class LibrosDb {
  static String _name = 'Libros';

  static Future<void> openBox() async {
    Hive.registerAdapter<LibrosModel>(LibrosModelAdapter());
    Hive.registerAdapter<Paginacion>(PaginacionAdapter());
    Hive.registerAdapter<Origen>(OrigenAdapter());
    await Hive.openBox<LibrosModel>(_name);
  }

  static Box<LibrosModel> getBox() => Hive.box(_name);
}
