import 'dart:developer' as dev;
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';
import 'package:viewpdf/DB/ListaData.dart';
import 'package:viewpdf/ManejoarPDF.dart';
import 'package:viewpdf/model/PDFModel.dart';

class EstanteriaProvider with ChangeNotifier {
  List<PDFModel> _lista = [];
  bool _loader = true;
  List<PDFModel> _pendientes = [];

  List<PDFModel> get lista => this._lista;

  set pendientes(List<PDFModel> val) {
    this._pendientes = val;

    notifyListeners();
  }

  set lista(List<PDFModel> val) {
    this._lista = val;

    notifyListeners();
  }

  List<PDFModel> get pendientes => this._pendientes;

  bool get loader => this._loader;

  Finder? _orden = Finder(
    // filter: Filter.equals("isTemporal", isTemporal),
    sortOrders: [
      SortOrder('isTemporal', false),
      SortOrder('actualizado', false),
    ],
  );
  Finder get orden => this._orden!;

  set orden(Finder finder) {
    this._orden = finder;
    notifyListeners();
  }

  set loader(bool val) {
    this._loader = val;
    notifyListeners();
  }

  Future<void> init() async {
    Finder finder = this._orden!;

    finder.filter = Filter.equals("isTemporal", true);
    this._pendientes = await EstanteriaDB.instance.listar(finder: finder);

    finder.filter = Filter.equals("isTemporal", false);
    this._lista = await EstanteriaDB.instance.listar(finder: finder);

    this._loader = false;

    notifyListeners();
  }

  Future<void> actualizarPDF(PDFModel pdf) async {
    pdf.actualizado = Timestamp.now();

    await EstanteriaDB.instance.actualizar(pdf);

    Finder finder = this._orden!;

    finder.filter = Filter.equals("isTemporal", false);
    this._lista = await EstanteriaDB.instance.listar(finder: finder);

    finder.filter = Filter.equals("isTemporal", true);
    this._pendientes = await EstanteriaDB.instance.listar(finder: finder);

    notifyListeners();
  }

  Future<void> limpiarlista() async {
    await EstanteriaDB.instance.eliminar(
      finder: Finder(
        filter: Filter.equals('isTemporal', true),
      ),
    );

    Finder finder = this._orden!;

    finder.filter = Filter.equals("isTemporal", false);
    this._lista = await EstanteriaDB.instance.listar(finder: finder);

    finder.filter = Filter.equals("isTemporal", true);
    this._pendientes = await EstanteriaDB.instance.listar(finder: finder);

    notifyListeners();
  }

  Future<bool> ordernarFiltrar({Finder? orden}) async {
    try {
      Finder finder = this._orden!;

      finder.filter = Filter.equals("isTemporal", false);
      this._lista = await EstanteriaDB.instance.listar(finder: finder);

      finder.filter = Filter.equals("isTemporal", true);
      this._pendientes = await EstanteriaDB.instance.listar(finder: finder);

      notifyListeners();
      return true;
    } catch (e) {
      dev.log(e.toString());
      return false;
    }
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
        String key = DateTime.now().millisecondsSinceEpoch.toString();
        key += "-" + generateRandomString(4);

        final portada = await ManejoarPDF().crearPortada(file.path!, key);

        pdf = await EstanteriaDB.instance.add(
          PDFModel(
            id: key,
            page: 0,
            path: file.path,
            portada: portada,
            name: file.name,
            actualizado: Timestamp.now(),
          ),
        );
      }
      return {'pdf': pdf, 'actualizar': result.count > 1};
    }
    return {'actualizar': false};
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }
}
