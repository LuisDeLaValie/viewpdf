import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SelectProvider with ChangeNotifier {
  bool _isSelect = false;
  bool get isSelect => this._isSelect;
  set isSelect(bool val) {
    this._isSelect = val;
    notifyListeners();
  }

  List<ItemSelect?> _listaSelects = [];
  List<ItemSelect?> get listaSelects => this._listaSelects;

  void selcet(ItemSelect val) {
    int res = this._listaSelects.indexOf(val);

    if (res > -1) {
      this._listaSelects.removeAt(res);
    } else {
      this._listaSelects.add(val);
    }
    if (!this._isSelect) this._isSelect = true;
    notifyListeners();
  }

  void multiselcet(List<ItemSelect> val) {
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
