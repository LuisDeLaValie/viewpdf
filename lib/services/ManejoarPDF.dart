import 'dart:developer';
import 'dart:io';

import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ManejoarPDF {
  Future<String> crearPortada(String path, String folder) async {
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
  }

  Future<String> moverPdf(String path, [String? folder]) async {
    try {
      File file = new File(path);
      String name = basename(path);
      String newpath = (await getApplicationDocumentsDirectory()).path;

      newpath += "/libros";
      if (folder != null) newpath += "/$folder";

      var newdirectoro = await Directory(newpath).create(recursive: true);
      var ruta = "${newdirectoro.path}/$name";
      File file2 = await file.copy(ruta);

      if (folder != null) await file.delete();

      return file2.path;
    } catch (e) {
      log("moverPdf ::: " + e.toString());
      return "";
    }
  }

  Future<bool> eliminarPDF(String path) async {
    try {
      File(path).delete();

      return true;
    } catch (e) {
      log("eliminarPDF ::: " + e.toString());
      return false;
    }
  }
}
