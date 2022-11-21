import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CrearLibroProvider with ChangeNotifier {
  bool _loader = true;

  bool get loader => this._loader;

  set loader(bool val) {
    this._loader = val;
    notifyListeners();
  }

  void init() async {
    notifyListeners();
  }


}
