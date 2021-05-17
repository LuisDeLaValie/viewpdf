import 'dart:developer';

import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';
import 'package:viewPDF/model/PDFModel.dart';

import 'db.dart';

class EstanteriaDB {
  EstanteriaDB._internal();
  static EstanteriaDB _instance = EstanteriaDB._internal();
  static EstanteriaDB get instance => EstanteriaDB._instance;

  final Database _db = DB.instance.database;
  final StoreRef<String, Map> _store = StoreRef<String, Map>("estanteria");

  int lenggth = 0;

  Future<void> init() async {
    lenggth = (await listar()).length;
  }

  Future<List<PDFModel>> listar({Finder finder}) async {
    List<RecordSnapshot<String, Map>> snapshots =
        await this._store.find(this._db, finder: finder);
    lenggth = snapshots.length ?? 0;
    return snapshots
        .map(
            (RecordSnapshot<String, Map> snap) => PDFModel.fromJson(snap.value))
        .toList();
  }

  Future<PDFModel> add(PDFModel pdf) async {
    pdf.id = lenggth + 1;
    PDFModel nuevoPDF = PDFModel.fromJson(
        await this._store.record("${pdf.id}").put(this._db, pdf.toJson()));
    lenggth++;
    return nuevoPDF;
  }

  Future<PDFModel> traer(int id) async {
    List<RecordSnapshot<String, Map>> data = await this
        ._store
        .find(this._db, finder: Finder(filter: Filter.byKey("$id")));

    return PDFModel.fromJson(data[0].value);
  }

  Future<int> eliminar({Finder finder}) async {
    return await this._store.delete(this._db, finder: finder);
  }

  Future<int> actualizar(PDFModel pdf) async {
    return await this._store.update(this._db, pdf.toJson(),
        finder: Finder(filter: Filter.byKey("${pdf.id}")));
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
    lenggth -= eliminados;
    log("Se eliminaron $eliminados temporales");

    return eliminados;
  }
}
