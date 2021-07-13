import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';
import 'package:viewPDF/DB/ListaData.dart';
import 'package:viewPDF/model/PDFModel.dart';

class EstanteriaProvider with ChangeNotifier {
  List<PDFModel> _lista = [];
  bool _loader = true;
  Finder? _orden;

  List<PDFModel> get lista => this._lista;
  bool get loader => this._loader;

  set loader(bool val) {
    this._loader = val;
  }

  set lista(List<PDFModel> val) {
    this._lista = val;
  }

  Future<void> init() async {
    _orden = Finder(
      sortOrders: [
        SortOrder('isTemporal', false),
        SortOrder('actualizado', false),
      ],
    );
    _lista = await EstanteriaDB.instance.listar(finder: _orden);
    _loader = false;

    notifyListeners();
  }

  Future<void> actualizarPDF(PDFModel pdf) async {
    pdf.actualizado = Timestamp.now();
    // pdf.isTemporal = false;

    await EstanteriaDB.instance.actualizar(pdf);
    _lista = await EstanteriaDB.instance.listar(finder: _orden);

    notifyListeners();
  }

  Future<void> limpiarlista() async {
    await EstanteriaDB.instance.eliminar(
      finder: Finder(
        filter: Filter.equals('isTemporal', true),
      ),
    );
    _lista = await EstanteriaDB.instance.listar(finder: _orden);
    notifyListeners();
  }

  Future<void> ordernarFiltrar({Finder? orden}) async {
    _orden = orden ?? _orden;
    _lista = await EstanteriaDB.instance.listar(finder: _orden);
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
        pdf = await EstanteriaDB.instance.add(PDFModel(
          page: 0,
          path: file.path,
          name: file.name,
          actualizado: Timestamp.now(),
        ));
      }
      return {'pdf': pdf, 'actualizar': result.count > 1};
    }
    return {'actualizar': false};
  }
}
