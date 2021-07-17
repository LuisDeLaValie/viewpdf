import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:viewpdf/DB/ListaData.dart';
import 'package:viewpdf/ManejoarPDF.dart';
import 'package:viewpdf/model/PDFModel.dart';

class PDFProvider with ChangeNotifier {
  int _allPage = 0;
  bool _loader = true;
  int _page = 0;
  PDFModel? _pdf;
  double _zoom = 1.0;

  int get allPage => this._allPage;

  set allPage(int val) {
    this._allPage = val;
    notifyListeners();
  }

  bool get loader => this._loader;

  PDFModel get pdf => this._pdf!;

  int get page => this._page;

  double get zoom => this._zoom;

  set page(int val) {
    this._page = val;
    notifyListeners();
  }

  set zoom(double val) {
    this._zoom = val;
    notifyListeners();
  }

  set loader(bool val) {
    this._loader = val;
    notifyListeners();
  }

  void init(PDFModel pdf) async {
    this._pdf = pdf;
    notifyListeners();
  }

  void actualizar({int? page, double? zoom}) async {
    final elpede = this._pdf!.copyWith(page: page, zoom: zoom);
    await EstanteriaDB.instance.actualizar(elpede);

    this._pdf = elpede;
    if (page != null) this._page = page;
    if (zoom != null) this.zoom = zoom;

    notifyListeners();
  }

  void guardarpdf() async {
    final path = await ManejoarPDF().moverPdf(this._pdf!.path!, this._pdf!.id!);

    final elpede = this._pdf!.copyWith(isTemporal: false, path: path);

    await EstanteriaDB.instance.actualizar(elpede);
    this._pdf = elpede;

    notifyListeners();
  }

  Future<void> eliminar() async {
    await EstanteriaDB.instance.eliminar(
      finder: Finder(
        filter: Filter.equals('id', this._pdf!.id),
      ),
    );
    await ManejoarPDF().eliminarPDF(this._pdf!.id!);
  }
}
