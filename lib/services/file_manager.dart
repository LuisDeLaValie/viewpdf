import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<String> mover(String? to) async {
    try {
      // obtener infomracion del archivo
      String directorio = (await getApplicationDocumentsDirectory()).path;
      File file = File(path);
      String name = basename(path);

      // crear el directorio
      String newpath = "$directorio/libros${to ?? ""}";
      await Directory(newpath).create(recursive: true);
      var ruta = "$newpath/$name";

      // mover archivo
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
