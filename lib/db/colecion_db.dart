part of '../model/colecion_model.dart';

class ColecionDb {
  static String _name = "Colecion";

  static Future<void> openBox() async {
    Hive.registerAdapter(ColecionModelAdapter());
    await Hive.openBox<ColecionModel>(_name);
  }

  static Box<ColecionModel> getBox() => Hive.box(_name);
}
