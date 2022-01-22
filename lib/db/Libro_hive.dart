import 'package:hive_flutter/hive_flutter.dart';
import 'package:viewpdf/model/PDFModel.dart';

class LibroHive {
  LibroHive._internal();
  static LibroHive _instance = LibroHive._internal();
  static LibroHive get instance => LibroHive._instance;

  String name = 'Libros';

  late Box<PDFModel> _box;
 Future<void> init() async {
    _box = await Hive.openBox<PDFModel>(name);
  }

  Box<PDFModel> get box => _box;
}
