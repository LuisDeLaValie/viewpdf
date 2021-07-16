import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:sembast/sembast.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:viewpdf/DB/ListaData.dart';
import 'package:viewpdf/ManejoarPDF.dart';
import 'package:viewpdf/Screen/pdfview/page.dart';

import 'package:viewpdf/model/PDFModel.dart';
import 'zoom.dart';

class MyPDF extends StatefulWidget {
  final PDFModel pdf;
  MyPDF({Key? key, required this.pdf}) : super(key: key);

  @override
  _MyPDFState createState() => _MyPDFState();
}

class _MyPDFState extends State<MyPDF> {
  late PDFModel pdf;
  TextEditingController? pageControler;
  PdfViewerController? pdfViewController;

  bool _mostrarAppbar = true;
  int allpague = 0;

  @override
  void initState() {
    this.pdf = widget.pdf;

    pageControler = new TextEditingController();
    pdfViewController = PdfViewerController();

    pdfViewController!.addListener(({property}) {
      // log("property: $property.");

      if (property == "pageCount") {
        pageControler!.text = "${pdf.page}";
        pdfViewController!.jumpToPage(pdf.page!);

        setState(() {
          allpague = pdfViewController!.pageCount;
        });
      } else if (property == "zoomLevel") {
        // pdfViewController.

      }
    });
    super.initState();
  }

  void cambiarZoom(bool sumres) {
    if (sumres)
      pdfViewController!.zoomLevel += 0.25;
    else
      pdfViewController!.zoomLevel -= 0.25;
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
                  pdfViewController!.jumpToPage(val); // .setPage();
                },
              ),
              actions: [
                ZoomPage(
                  zoomChange: cambiarZoom,
                  initZoom: pdf.zoom!,
                ),
                myPopMenu(),
              ],
            )
          : null,
      body: SfPdfViewer.file(
        File(pdf.path!),
        initialZoomLevel: pdf.zoom!,
        controller: pdfViewController,
        onPageChanged: (chane) {
          pageControler!.text = "${pdfViewController!.pageNumber}";
          pdf.page = pdfViewController!.pageNumber;
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
          setState(() {
            pdf.zoom = ash.newZoomLevel;
          });
          EstanteriaDB.instance.actualizar(pdf);
          log("ZOOM :: " + pdfViewController!.zoomLevel.toString());
        },
      ),
    );
  }

  Widget myPopMenu() {
    return PopupMenuButton(
      onSelected: (dynamic value) {
        if (value == 1) {
          guardarpdf();
        } else if (value == 2) {
          showMyDialog();
        } else if (value == 3) {
          eliminar();
        }
      },
      itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
        if (pdf.isTemporal!)
          PopupMenuItem(
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
          ),
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
    final path = await ManejoarPDF().moverPdf(pdf.path!, pdf.id!);

    pdf.isTemporal = false;
    pdf.path = path;

    await EstanteriaDB.instance.actualizar(pdf);
    pdf = await EstanteriaDB.instance.traer(pdf.id);

    setState(() {});
  }

  void eliminar() async {
    await EstanteriaDB.instance.eliminar(
      finder: Finder(
        filter: Filter.equals('id', pdf.id),
      ),
    );
    await ManejoarPDF().eliminarPDF(pdf.id!);
    Navigator.of(this.context).pop();
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Path del archivo.'),
          content: Text(pdf.path!),
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
