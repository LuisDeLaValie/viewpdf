import 'dart:developer';
import 'dart:io';

import 'package:native_pdf_renderer/native_pdf_renderer.dart';
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
      log(e.toString());
      return "";
    }
  }

  moverPdf(String path, String folder) {}
}
