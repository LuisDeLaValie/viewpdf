import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:viewpdf/DB/libreria_Store.dart';
import 'package:viewpdf/services/ManejoarPDF.dart';
import 'package:viewpdf/model/PDFModel.dart';

class PDFProvider with ChangeNotifier {
  int _allPage = 0;
  bool _loader = true;
  int _page = 0;
  late PDFModel _pdf;
  double _zoom = 0.0;

  void init(PDFModel pdf) {
    this._zoom = pdf.zoom;
    this._page = pdf.page;
    this._pdf = pdf;
  }

  double get zoom => this._zoom;

  set zoom(double val) {
    this._zoom = val;
    notifyListeners();
  }

  int get page => this._page;

  set page(int val) {
    this._page = val;
    notifyListeners();
  }

  PDFModel get pdf => this._pdf;

  set pdf(PDFModel val) {
    this._pdf = val;
  }

  int get allPage => this._allPage;

  set allPage(int val) {
    this._allPage = val;
    notifyListeners();
  }

  bool get loader => this._loader;

  set loader(bool val) {
    this._loader = val;
    notifyListeners();
  }

  Future<void> actualizar() async {
    this._pdf
      ..page = this._page
      ..zoom = this._zoom;

    await LibreriaStore.instance
        .actualizar(this._pdf.toMap(), id: this._pdf.id);
  }

  void guardarpdf() async {
    this._pdf.isTemporal = false;

    notifyListeners();
  }

  Future<void> eliminar() async {
    await LibreriaStore.instance.eliminar(
      finder: Finder(
        filter: Filter.equals('id', this._pdf.id),
      ),
    );
    await ManejoarPDF().eliminarPDF(this._pdf.id);
  }
}
