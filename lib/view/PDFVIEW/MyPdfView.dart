import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:viewPDF/DB/ListaData.dart';

import 'package:viewPDF/model/PDFModel.dart';
import 'package:viewPDF/view/pdfview/page.dart';
import 'zoom.dart';

class MyPDF extends StatefulWidget {
  final PDFModel pdf;
  MyPDF({Key key, @required this.pdf}) : super(key: key);

  @override
  _MyPDFState createState() => _MyPDFState();
}

class _MyPDFState extends State<MyPDF> {
  PDFModel pdf;
  TextEditingController pageControler;
  PdfViewerController pdfViewController;

  bool _mostrarAppbar = true;
  int allpague = 0;

  @override
  void initState() {
    this.pdf = widget.pdf;

    pageControler = new TextEditingController();
    pdfViewController = PdfViewerController();

    pdfViewController.addListener(({property}) {
      log("property: $property.");

      if (property == "pageCount") {
        pageControler.text = "${pdf.page}";
        pdfViewController.jumpToPage(pdf.page);

        setState(() {
          allpague = pdfViewController.pageCount;
        });
      } else if (property == "zoomLevel") {
        // pdfViewController.
        pdf.zoom = pdfViewController.zoomLevel;
        EstanteriaDB.instance.actualizar(pdf);
        log("ZOOM :: " + pdfViewController.zoomLevel.toString());
      }
    });
    super.initState();
  }

  void cambiarZoom(bool sumres) {
    if (sumres)
      pdfViewController.zoomLevel += 0.25;
    else
      pdfViewController.zoomLevel -= 0.25;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _mostrarAppbar
          ? AppBar(
              title: LaPage(
                allPage: allpague,
                pageController: pageControler,
                page: (val) {
                  pdfViewController.jumpToPage(val); // .setPage();
                },
              ),
              actions: [
                ZoomPage(
                  zoomChange: cambiarZoom,
                  initZoom: pdf.zoom,
                ),
                myPopMenu(),
              ],
            )
          : null,
      body: Container(
        child: SfPdfViewer.file(
          File(pdf.path),
          initialZoomLevel: pdf.zoom,
          controller: pdfViewController,
          onPageChanged: (chane) {
            pageControler.text = "${pdfViewController.pageNumber}";
            pdf.page = pdfViewController.pageNumber;
            EstanteriaDB.instance.actualizar(pdf);
            log("onPageChanged :: " + "${chane.newPageNumber}");
          },
          onDocumentLoaded: (load) {
            log("onDocumentLoaded :: " + load.toString());
          },
          onDocumentLoadFailed: (fail) {
            log("onDocumentLoadFailed :: " + fail.toString());
          },
          onTextSelectionChanged: (asa) {
            log("onTextSelectionChanged :: " + asa.toString());
          },
          onZoomLevelChanged: (ash) {
            log("onZoomLevelChanged :: " + ash.toString());
          },
        ),
      ),
    );
  }

  Widget myPopMenu() {
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 1) {
          guardarpdf();
        } else if (value == 2) {
          showMyDialog();
        } else if (value == 3) {
          eliminar();
        }
      },
      itemBuilder: (context) => [
        (pdf.isTemporal)
            ? PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: Icon(
                        Icons.save_alt,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Guardar',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              )
            : null,
        PopupMenuItem(
          value: 2,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                child: Icon(
                  Icons.content_paste_sharp,
                  color: Colors.grey,
                ),
              ),
              Text(
                'ver Ubicacion.',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                child: Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Eliminar.',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
      ],
    );
  }

  void guardarpdf() async {
    File file = new File(pdf.path);
    String name = basename(file.path);

    final String path = (await getApplicationDocumentsDirectory()).path;
    File file2 = await file.copy("$path/$name");

    pdf.isTemporal = false;
    pdf.path = file2.path;

    await EstanteriaDB.instance.actualizar(pdf);
    pdf = await EstanteriaDB.instance.traer(pdf.id);
    await file.delete();
    setState(() {});
  }

  void eliminar() async {
    await EstanteriaDB.instance.eliminar(
      finder: Finder(
        filter: Filter.equals('id', pdf.id),
      ),
    );
    File file = File(pdf.path);
    await file.delete();
    Navigator.of(this.context).pop();
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Path del archivo.'),
          content: Text(pdf.path),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
