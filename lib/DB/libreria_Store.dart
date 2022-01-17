import 'dart:developer';

import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';
import 'package:viewpdf/DB/db.dart';
import 'package:viewpdf/model/PDFModel.dart';

class LibreriaStore {
  LibreriaStore._internal();
  static LibreriaStore _instance = LibreriaStore._internal();
  static LibreriaStore get instance => LibreriaStore._instance;

  final Database? _db = DB.instance.database;
  final StoreRef<String, Map> _store = StoreRef<String, Map>("libreria");

  Future<List<PDFModel>> listar({Finder? finder}) async {
    final snapshots = await this._store.find(this._db!, finder: finder);
    return snapshots
        .map((snap) => PDFModel.fromMap(snap.value as Map<String, dynamic>))
        .toList();
  }

  Future<PDFModel> add(PDFModel pdf) async {
    final neow = await this._store.record(pdf.id).put(this._db!, pdf.toMap())
        as Map<String, dynamic>;

    PDFModel nuevoPDF = PDFModel.fromMap(neow);

    return nuevoPDF;
  }

  Future<PDFModel> traer(String? id) async {
    final data = await this._store.find(
          this._db!,
          finder: Finder(
            filter: Filter.byKey(id),
          ),
        );

    return PDFModel.fromMap(data[0].value as Map<String, dynamic>);
  }

  Future<int> eliminar({Finder? finder}) =>
      this._store.delete(this._db!, finder: finder);

  Future<int> actualizar(Map<String, dynamic> data,
      {Finder? filter, String? id}) async {
    Finder? filtrar;

    if (filter == null && id == null)
      throw ("id y filter no null");
    else if (filter != null)
      filtrar = filter;
    else
      filtrar = Finder(filter: Filter.byKey(id));

    return await this._store.update(this._db!, data, finder: filtrar);
  }

  Future<int> eliminarTemporal() async {
    DateTime hoy = new DateTime.now();
    DateTime semana = hoy.subtract(Duration(days: 3));
    Timestamp nueva = Timestamp.fromDateTime(semana);

    int eliminados = await this.eliminar(
      finder: Finder(
        filter: Filter.and([
          Filter.equals('isTemporal', true),
          Filter.lessThan('actualizado', nueva),
        ]),
      ),
    );
    log("Se eliminaron $eliminados temporales");

    return eliminados;
  }
}
