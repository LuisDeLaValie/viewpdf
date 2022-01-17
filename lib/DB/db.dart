import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:viewpdf/model/EstanteriaModel.dart';
import 'package:viewpdf/model/PDFModel.dart';

class DB {
  DB._internal();
  static DB _instance = DB._internal();
  static DB get instance => DB._instance;

  Database? _database;

  Database? get database => this._database;

  Future<void> init() async {
    final String dbName = "flutter_avanzado.db";

    final String dir = (await getApplicationDocumentsDirectory()).path;

    final String dbPath = join(dir, dbName);

    this._database = await databaseFactoryIo.openDatabase(
      dbPath,
      version: 2,
      onVersionChanged: (db, old, neo) async {
        print("Version changed from $old to $neo");

        if (old <= 1) {
          final StoreRef<String, Map> storeanteriro =
              StoreRef<String, Map>("libreria");
          final anterior = await storeanteriro.find(db);

          final StoreRef<String, Map> storenuevo =
              StoreRef<String, Map>("libreria");
          await storenuevo.addAll(
              db,
              anterior
                  .map((snap) => snap.value as Map<String, dynamic>)
                  .toList());
          await storeanteriro.delete(db);

          storeanteriro.addAll(
              db,
              anterior.map((snap) {
                final val =
                    PDFModel.fromMap(snap.value as Map<String, dynamic>);
                return EstanteriaModel(
                        key: "Esta-${val.id}",
                        nombre: val.name,
                        libros: [
                          LibroEstanteria(key: val.id, nombre: val.name)
                        ],
                        isColeection: false)
                    .toMap();
              }).toList());

          print("nuevo");
        }
      },
    );
  }

  Future<void> close() async {
    await this._database!.close();
  }
}
