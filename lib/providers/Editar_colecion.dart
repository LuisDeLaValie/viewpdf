import 'package:flutter/material.dart';

class EditarColecionProvider with ChangeNotifier {
  bool _onEdit = false;
  bool get onEdit => this._onEdit;
  set onEdit(bool val) {
    this._onEdit = val;
    notifyListeners();
  }

  String nombre = '';
}
