

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class CrearLibroProvider with ChangeNotifier {
  TextEditingController titulo = TextEditingController();
  // TextEditingController titulo = TextEditingController();
  // TextEditingController titulo = TextEditingController();
  // TextEditingController titulo = TextEditingController();
  // TextEditingController titulo = TextEditingController();
  // TextEditingController titulo = TextEditingController();
  // TextEditingController titulo = TextEditingController();

  bool _loader = true;

  bool get loader => this._loader;

  set loader(bool val) {
    this._loader = val;
    notifyListeners();
  }

  void init() async {
    notifyListeners();
  }

  void importar() async {
    FilePickerResult? result;

    try {
      result = await FilePicker.platform.pickFiles();
    } catch (e) {
      print(e);
    }

    if (result != null) {
      // Uint8List fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;
      print(fileName);
    }

    // FilePickerResult? result;
    // try {
    //   result = await FilePicker.platform.pickFiles(
    //     type: FileType.custom,
    //     allowedExtensions: ['pdf', 'doc'],
    //   );
    // } catch (e) {
    //   log(e.toString());
    // }

    // if (result != null) {
    //   File file = File.fromRawPath(result.files.first.bytes!);
    //   var libros = LibrosModel.importar(file.path);
    //   notifyListeners();
    // }
  }
}
