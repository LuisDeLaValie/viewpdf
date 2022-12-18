part of '../model/autor_model.dart';

class AutorDB {
  static String _name = "Autor";

  static Future<void> openBox() async {
    Hive.registerAdapter(AutorModelAdapter());
    await Hive.openBox<AutorModel>(_name);
  }

  static Box<AutorModel> getBox() => Hive.box(_name);
}
