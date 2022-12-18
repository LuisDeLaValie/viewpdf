import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:viewpdf/api/biblioteca_api.dart';
import 'package:viewpdf/model/colecion_model.dart';

import '../model/estanteria_model.dart';
import '../model/libros_model.dart';

enum FiltroEstanteria { libors, colenciones, todos }

class HomeProvider with ChangeNotifier {
  List<EstanteriaModel> estanteria = [];

  FiltroEstanteria _filto = FiltroEstanteria.todos;
  FiltroEstanteria get filto => this._filto;
  set filto(FiltroEstanteria val) {
    this._filto = val;
    notifyListeners();
  }

  String _search = "";
  String get search => this._search;
  set search(String val) {
    this._search = val;
    notifyListeners();
    getEstanteria();
  }

  Future<void> getEstanteria() async {
    try {
      dynamic data;
      switch (filto) {
        case FiltroEstanteria.libors:
          data = await BibliotecaApi().get("/libros", {
            if (_search.isNotEmpty) "search": search,
            "only": "true",
          });
          estanteria = (data['libros'] as List)
              .map((e) => LibrosModel.fromApi(e)..save())
              .toList();

          break;
        case FiltroEstanteria.colenciones:
          data = await BibliotecaApi().get("/coleccion", {
            if (_search.isNotEmpty) "search": search,
          });
          estanteria = (data['coleccion'] as List).map((e) {
            return ColecionModel.fromApi(e)..save();
          }).toList();

          break;
        case FiltroEstanteria.todos:
          data = await BibliotecaApi().get("/libros", {
            if (_search.isNotEmpty) "search": search,
            "only": "false",
          });
          estanteria = (data['libros'] as List)
              .map((e) => LibrosModel.fromApi(e)..save())
              .toList();

          break;
      }

      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
