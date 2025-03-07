import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:viewpdf/DB/ListaData.dart';
import 'package:viewpdf/ManejoarPDF.dart';
import 'package:viewpdf/model/PDFModel.dart';

class EstanteriaProvider with ChangeNotifier {
  List<PDFModel>? _guardados;
  bool _loader = true;
  List<PDFModel>? _pendiens;

  List<PDFModel>? get pendiens => this._pendiens;

  Future<void> listarpendiens() async {
    final noti = this._pendiens != null;
    this._pendiens = await EstanteriaDB.instance.listar(
      finder: Finder(
        filter: Filter.equals("isTemporal", true),
      ),
    );
    if (noti) notifyListeners();
  }

  List<PDFModel>? get guardados => this._guardados;

  Future<void> listarguardados() async {
    final noti = this._guardados != null;
    this._guardados = await EstanteriaDB.instance.listar(
      finder: Finder(
        filter: Filter.equals("isTemporal", false),
      ),
    );
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
    Filter filter;
    if (keys == null)
      filter = Filter.equals('isTemporal', true);
    else
      filter = Filter.inList('id', keys);

    await EstanteriaDB.instance.eliminar(
      finder: Finder(filter: filter),
    );
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
      String key = DateTime.now().millisecondsSinceEpoch.toString();
      for (var file in result.files) {
        key += "-" + generateRandomString(4);

        final path = await ManejoarPDF().moverPdf(file.path!, key);

        pdf = await EstanteriaDB.instance.add(
          PDFModel(
            id: key,
            page: 0,
            path: path,
            name: file.name,
            actualizado: DateTime.now(),
          ),
        );
      }
      return {'pdf': pdf, 'actualizar': result.count == 1};
    }
    return {'actualizar': false};
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  Future<void> guardarpdf(List<String> keys) async {
    final res = await EstanteriaDB.instance.actualizar(
      {'isTemporal': false},
      filter: Finder(
        filter: Filter.inList('id', keys),
      ),
    );

    this._guardados = null;
    this._pendiens = null;

    await listarpendiens();
    await listarguardados();

    notifyListeners();
  }
}
