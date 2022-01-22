import 'package:sembast/sembast.dart';
import 'package:viewpdf/DB/db.dart';
import 'package:viewpdf/model/EstanteriaModel.dart';

class EstatnteriaStore {
  EstatnteriaStore._internal();
  static EstatnteriaStore _instance = EstatnteriaStore._internal();
  static EstatnteriaStore get instance => EstatnteriaStore._instance;

  final Database? _db = DB.instance.database;
  final StoreRef<String, Map> _store = StoreRef<String, Map>("estatnteria");

  Future<List<EstanteriaModel?>> listar({Finder? finder}) async {
    final snapshots = await this._store.find(this._db!, finder: finder);

    final lista = snapshots
        .map((snap) =>
            EstanteriaModel.fromMap(snap.value as Map<String, dynamic>))
        .toList();

    return lista;
  }

  Future<EstanteriaModel?> ver({Finder? finder}) async {
    final snapshots = await this._store.findFirst(this._db!, finder: finder);

    if (snapshots == null) return null;

    return EstanteriaModel.fromMap(snapshots.value as Map<String, dynamic>);
  }

  Future<void> crear(EstanteriaModel colecion) async {
    final neow = await this._store.add(this._db!, colecion.toMap());
  }

  Future<void> agregar(List<EstanteriaModel> colecion) async {
    final neow = await this
        ._store
        .addAll(this._db!, colecion.map((e) => e.toMap()).toList());
  }

  void editar(EstanteriaModel colecion) async {
    final neow = await this._store.update(this._db!, colecion.toMap(),
        finder: Finder(filter: Filter.byKey(colecion.key)));
  }

  Future<void> eliminar({Finder? filter}) async {
    final neow =
        await this._store.delete(this._db!, finder:  filter);
  }
}
