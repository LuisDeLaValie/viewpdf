

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:viewpdf/model/PDFModel.dart';
import 'package:viewpdf/services/libros.dart';

class EstanteriaProvider with ChangeNotifier {
  List<PDFModel?>? _guardados;
  bool _loader = true;
  List<PDFModel?>? _pendiens;

  List<PDFModel?>? get pendiens => this._pendiens;

  Future<void> listarpendiens() async {
    final noti = this._pendiens != null;

    this._pendiens = await Libros.listarLibros(true);

    if (noti) notifyListeners();
  }

  List<PDFModel?>? get guardados => this._guardados;

  Future<void> listarguardados() async {
    final noti = this._guardados != null;
    this._guardados = await Libros.listarLibros(false);
    if (noti) notifyListeners();
  }

  bool get loader => this._loader;

  set loader(bool val) {
    this._loader = val;
    notifyListeners();
  }

  Future<void> init() async {
    await listarpendiens();
    await listarguardados();
    this._loader = false;
    notifyListeners();
  }

  Future<void> limpiarlista({List<String>? keys}) async {
    await Libros.limpiar(keys: keys);
    listarpendiens();
    listarguardados();

    notifyListeners();
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
        pdf = await Libros.nuevoPDF(file.name, file.path!);
      }
      return {'pdf': pdf, 'actualizar': result.count == 1};
    }
    return {'actualizar': false};
  }

  Future<void> guardarpdf(List<String> keys) async {
    await Libros.guardar(keys);

    this._guardados = null;
    this._pendiens = null;

    await listarpendiens();
    await listarguardados();

    notifyListeners();
  }
}
