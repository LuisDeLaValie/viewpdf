import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:viewpdf/Colors/ColorA.dart';

class Portada extends StatefulWidget {
  final String path;
  const Portada({Key? key, required this.path}) : super(key: key);

  @override
  _PortadaState createState() => _PortadaState();
}

class _PortadaState extends State<Portada> {
  Uint8List? lista;

  @override
  void initState() {
    super.initState();
    loaderPortada();
  }

  String oldPath = "";
  loaderPortada() async {
    final document = await PdfDocument.openFile(widget.path);
    final page = await document.getPage(1);
    final image = await page.render(width: page.width, height: page.height);
    await page.close();

    setState(() {
      lista = image!.bytes;
      oldPath = widget.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (oldPath != widget.path) loaderPortada();
    if (lista == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
            color: ColorA.burntSienna,
          ),
        ),
      );
    } else {
      return Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.memory(
              lista!,
              fit: BoxFit.fill,
            )),
      );
    }
  }
}
