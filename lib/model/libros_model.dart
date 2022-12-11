import 'dart:developer';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

import 'autor_model.dart';

// part 'libros_model.g.dart';

@HiveType(typeId: 0)
class LibrosModel {
  @HiveField(0)
  final String? key;
  @HiveField(1)
  final String titulo;
  @HiveField(2)
  final String? sinopsis;
  @HiveField(3)
  final List<AutorModel>? autores;
  @HiveField(4)
  final String? editorail;
  @HiveField(5)
  final String? path;
  @HiveField(6)
  final Paginacion? paginacion;
  @HiveField(7)
  final Origen? origen;
  @HiveField(8)
  final DateTime creado;

  LibrosModel({
    this.key,
    required this.titulo,
    this.sinopsis,
    this.autores,
    this.editorail,
    this.path,
    this.paginacion,
    this.origen,
    required this.creado,
  });

  String get portada =>
      "https://lh3.google.com/u/0/d/$path=w200-h190-p-k-nu-iv1";

  factory LibrosModel.fromApi(Map<String, dynamic> data) {
    return LibrosModel(
      key: data["key"],
      titulo: data["titulo"],
      sinopsis: data["sipnosis"],
      autores: data["autores"] != null
          ? (data["autores"] as List).map((e) => AutorModel.fromApi(e)).toList()
          : null,
      editorail: data["editorial"],
      path: data["-"],
      paginacion: data["paginacion"] != null
          ? Paginacion.fromApi(data["paginacion"])
          : null,
      origen: data["origen"] != null ? Origen.fromApi(data["origen"]) : null,
      creado: DateTime.parse(data["creado"]),
    );
  }

  static Future<LibrosModel> importar(String file) async {
    // libro = libro.copyWith(
    //   titulo: file.split("/").last.replaceFirst('.\W{0,3}', ''),
    // );

    final document = await PdfDocument.openFile('path/to/file/on/device');
    var libro = LibrosModel(
      titulo: document.sourceName,
      paginacion: Paginacion(
        0,
        document.pagesCount,
      ),
      creado: DateTime.now(),
    );

    return libro;
  }

  LibrosModel copyWith({
    String? titulo,
    String? sinopsis,
    List<AutorModel>? autores,
    String? editorail,
    String? path,
    Paginacion? paginacion,
    Origen? origen,
    DateTime? creado,
  }) {
    return LibrosModel(
      key: this.key,
      titulo: titulo ?? this.titulo,
      sinopsis: sinopsis ?? this.sinopsis,
      autores: autores ?? this.autores,
      editorail: editorail ?? this.editorail,
      path: path ?? this.path,
      paginacion: paginacion ?? this.paginacion,
      origen: origen ?? this.origen,
      creado: creado ?? this.creado,
    );
  }
}

class Paginacion {
  final int to;
  final int end;

  Paginacion(this.to, this.end);
  factory Paginacion.fromApi(Map<String, dynamic> data) {
    return Paginacion(
      data["To"],
      data["End"],
    );
  }
}

class Origen {
  final String nombre;
  final String url;

  Origen(this.nombre, this.url);

  factory Origen.fromApi(Map<String, dynamic> data) {
    return Origen(
      data["nombre"],
      data["url"],
    );
  }
}

class FileManager {
  final String path;

  FileManager(this.path);

/* Future<String> crearPortada(String path, String folder) async {
    try {
      final document = await PdfDocument.openFile(path);
      final page = await document.getPage(1);
      final image = await page.render(width: page.width, height: page.height);
      await page.close();

      final String newpath = (await getApplicationDocumentsDirectory()).path;
      await Directory("$newpath/$folder").create();
      final file1 = File("$newpath/$folder/thumbnail.png");
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
