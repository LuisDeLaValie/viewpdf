import 'dart:developer';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

import 'autor_model.dart';
import 'estanteria_model.dart';

part 'libros_model.g.dart';
part '../db/libros_db.dart';

@HiveType(typeId: 0)
class LibrosModel extends HiveObject implements EstanteriaModel {
  @HiveField(0)
  late String? key;
  @HiveField(1)
  late String titulo;
  @HiveField(2)
  late String? sinopsis;
  @HiveField(3)
  late HiveList<AutorModel>? autores;
  @HiveField(4)
  late String? editorail;
  @HiveField(5)
  late String? path;
  @HiveField(6)
  late Paginacion? paginacion;
  @HiveField(7)
  late Origen? origen;
  @HiveField(8)
  late DateTime? creado;
  @HiveField(9)
  late String? descargar;
  @HiveField(10)
  late String? ver;
  LibrosModel();

  String get portada =>
      "https://lh3.google.com/u/0/d/$path=w200-h190-p-k-nu-iv1";

  factory LibrosModel.fromApi(Map<String, dynamic> data) {
    List<AutorModel>? autores = (data["autores"] as List)
        .map((e) => AutorModel.fromApi(e)..save())
        .toList();

    var aux = LibrosModel()
      ..key = data["key"]
      ..titulo = data["titulo"]
      ..sinopsis = data["Sinopsis"]
      ..autores = data["autores"] != null
          ? HiveList(AutorDB.getBox(), objects: autores)
          : null
      ..editorail = data["editorial"]
      ..path = data["-"]
      ..descargar = data['descargar']
      ..ver = data['ver']
      ..paginacion = data["paginacion"] != null
          ? Paginacion.fromApi(data["paginacion"])
          : null
      ..origen = data["origen"] != null ? Origen.fromApi(data["origen"]) : null
      ..creado = DateTime.parse(data["creado"]);
    return aux;
  }

  static Future<LibrosModel> importar(String file) async {
    // libro = libro.copyWith(
    //   titulo: file.split("/").last.replaceFirst('.\W{0,3}', ''),
    // );

    var document = await PdfDocument.openFile('path/to/file/on/device');
    var libro = LibrosModel()
      ..titulo = document.sourceName
      ..paginacion = Paginacion(0, document.pagesCount)
      ..creado = DateTime.now();

    return libro;
  }

  @override
  Future<void> save() {
    if (box != null) {
      return box!.put(key, this);
    } else {
      return LibrosDb.getBox().put(key, this);
    }
  }
}

@HiveType(typeId: 1)
class Paginacion {
  @HiveField(0)
  late int to;
  @HiveField(1)
  late int end;

  Paginacion(this.to, this.end);
  factory Paginacion.fromApi(Map<String, dynamic> data) {
    return Paginacion(
      data["To"],
      data["End"],
    );
  }
}

@HiveType(typeId: 2)
class Origen {
  @HiveField(0)
  late String nombre;
  @HiveField(1)
  late String url;

  Origen(this.nombre, this.url);

  factory Origen.fromApi(Map<String, dynamic> data) {
    return Origen(
      data["nombre"],
      data["url"],
    );
  }
}

class FileManager {
  late String path;

  FileManager(this.path);

/* Future<String> crearPortada(String path, String folder) async {
    try {
      late document = await PdfDocument.openFile(path);
      late page = await document.getPage(1);
      late image = await page.render(width: page.width, height: page.height);
      await page.close();

      late String newpath = (await getApplicationDocumentsDirectory()).path;
      await Directory("$newpath/$folder").create();
      late file1 = File("$newpath/$folder/thumbnail.png");
      await file1.writeAsBytes(image!.bytes);

      return file1.path;
    } catch (e) {
      log("crearPortada ::: " + e.toString());
      return "";
    }
  } */

  Future<String> mover(String newpath) async {
    try {
      String directorio = (await getApplicationDocumentsDirectory()).path;
      File file = File(path);
      String name = basename(path);

      String _newpath = "$directorio/libros/$newpath";
      await Directory(_newpath).create(recursive: true);
      var ruta = "$_newpath/$name";

      await file.copy(ruta);
      await file.delete();

      return ruta;
    } catch (e) {
      log(e.toString(), name: "Mover file");
      return "";
    }
  }

  Future<bool> eliminar() async {
    try {
      await File(path).delete();
      return true;
    } catch (e) {
      log(e.toString(), name: "Eliminar File");
      return false;
    }
  }
}
