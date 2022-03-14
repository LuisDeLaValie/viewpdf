import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SelectProvider with ChangeNotifier {
  bool _isSelect = false;
  bool get isSelect => this._isSelect;
  set isSelect(bool val) {
    this._isSelect = val;
    notifyListeners();
  }

  List<String> _listaSelects = [];
  List<String> get listaSelects => this._listaSelects;

  void selcet(String val) {
    bool res = this._listaSelects.contains(val);

    if (res) {
      this._listaSelects.remove(val);
    } else {
      this._listaSelects.add(val);
    }
    if (!this._isSelect) this._isSelect = true;
    notifyListeners();
  }

  void multiselcet(List<String> val) {
    this._listaSelects = val;
    notifyListeners();
  }

  void cancel() {
    this._isSelect = false;
    this._listaSelects.clear();
    notifyListeners();
  }
}

class ItemSelect {
  final int index;
  final String key;
  ItemSelect({required this.index, required this.key});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemSelect && other.index == index && other.key == key;
  }

  @override
  int get hashCode => index.hashCode ^ key.hashCode;

  @override
  String toString() => 'ItemSelect(index: $index, key: $key)';
}
