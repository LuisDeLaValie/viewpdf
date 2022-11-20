// import 'dart:developer';
// import 'dart:io';

// import 'package:hive/hive.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// import 'autor_model.dart';

// part 'libros_model.g.dart';

// @HiveType(typeId: 0)
// class LibrosModel {
//   @HiveField(0)
//   final String key;
//   @HiveField(0)
//   final String titulo;
//   @HiveField(0)
//   final String sinopsis;
//   @HiveField(0)
//   final List<AutorModel> autores;
//   @HiveField(0)
//   final String editorail;
//   @HiveField(0)
//   final String descargar;
//   @HiveField(0)
//   final String path;
//   @HiveField(0)
//   final String ver;
//   @HiveField(0)
//   final Paginacion paginacion;
//   @HiveField(0)
//   final Origen origen;
//   @HiveField(0)
//   final DateTime creado;

//   LibrosModel(this.key, this.titulo, this.sinopsis, this.autores, this.editorail, this.descargar, this.path, this.ver, this.paginacion, this.origen, this.creado);
// }

// class Paginacion {
//   final int to;
//   final int end;

//   Paginacion(this.to, this.end);
// }

// class Origen {
//   final String nombre;
//   final String url;

//   Origen(this.nombre, this.url);
// }

// class FileManager {
//   final String path;

//   FileManager(this.path);

// /* Future<String> crearPortada(String path, String folder) async {
//     try {
//       final document = await PdfDocument.openFile(path);
//       final page = await document.getPage(1);
//       final image = await page.render(width: page.width, height: page.height);
//       await page.close();

//       final String newpath = (await getApplicationDocumentsDirectory()).path;
//       await Directory("$newpath/$folder").create();
//       final file1 = File("$newpath/$folder/thumbnail.png");
//       await file1.writeAsBytes(image!.bytes);

//       return file1.path;
//     } catch (e) {
//       log("crearPortada ::: " + e.toString());
//       return "";
//     }
//   } */

//   Future<String> mover(String newpath) async {
//     try {
//       // obtener infomracion del archivo
//       String directorio = (await getApplicationDocumentsDirectory()).path;
//       File file = File(path);
//       String name = basename(path);

//       // crear el directorio
//       String _newpath = "$directorio/libros/$newpath";
//       await Directory(_newpath).create(recursive: true);
//       var ruta = "$_newpath/$name";

//       // mover archivo
//       await file.copy(ruta);
//       await file.delete();

//       return ruta;
//     } catch (e) {
//       log(e.toString(), name: "Mover file");
//       return "";
//     }
//   }

//   Future<bool> eliminar() async {
//     try {
//       await File(path).delete();
//       return true;
//     } catch (e) {
//       log(e.toString(), name: "Eliminar File");
//       return false;
//     }
//   }
// }
