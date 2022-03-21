import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:viewpdf/model/PDFModel.dart';
import 'package:viewpdf/services/libros.dart';

class EstanteriaProvider with ChangeNotifier {
  EstanteriaProvider() {
    _libros = Libros();
  }

  late Libros _libros;
  bool _loader = false;

  bool get loader => this._loader;

  List<String> pendienteKes = [];
  List<String> guardadosKesy = [];

  set loader(bool val) {
    this._loader = val;
    notifyListeners();
  }

  Future<void> limpiarlista({List<String>? keys}) async {
    await _libros.limpiar(keys: keys);
  }

  Future<Map<String, dynamic>> getPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PDFModel? pdf;
      for (var file in result.files) {
        pdf = await _libros.nuevoPDF(file.name, file.path!);
      }
      return {'pdf': pdf, 'actualizar': result.count == 1};
    }
    return {'actualizar': false};
  }

  Future<void> guardarpdf(List<String> keys) => _libros.guardar(keys);
}
