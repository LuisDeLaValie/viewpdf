import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:viewPDF/data/ListaData.dart';

class MyPDF extends StatefulWidget {
  final int id;
  MyPDF({Key key, this.id}) : super(key: key);

  @override
  _MyPDFState createState() => _MyPDFState();
}

class _MyPDFState extends State<MyPDF> {
  PDFModel pdf;
  TextEditingController pageControler;
  PdfViewerController pdfViewController;
  bool _mostrarAppbar = true;
  int allpague = 0;
  bool isTemporal = true;

  @override
  void initState() {
    pageControler = new TextEditingController();

    pdfViewController = PdfViewerController();
    pdfViewController.addListener(({property}) {
      log("property: $property");
      if (property == "pageCount") {
        pageControler.text = "${pdf.page}";
        pdfViewController.jumpToPage(pdf.page);

        setState(() {
          allpague = pdfViewController.pageCount;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _mostrarAppbar
          ? AppBar(
              title: Container(
                child: Center(
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 30,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: pageControler,
                          keyboardType: TextInputType.number,
                          onSubmitted: (s) {
                            pdfViewController
                                .jumpToPage(int.parse(s)); // .setPage();
                          },
                        ),
                      ),
                      Text("/$allpague")
                    ],
                  ),
                ),
              ),
              actions: [
                myPopMenu(),
              ],
            )
          : null,
      body: Container(
        child: FutureBuilder(
          future: _getpdf(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SfPdfViewer.file(
                File(pdf.path),
                initialZoomLevel: 1.1,
                controller: pdfViewController,
                onPageChanged: (chane) {
                  pageControler.text = "${pdfViewController.pageNumber}";
                  pdf.page = pdfViewController.pageNumber;
                  EstanteriaDB.instance.actualizar(pdf);
                  log("${chane.newPageNumber}");
                },
                onDocumentLoaded: (load) {
                  log(load.toString());
                },
                onDocumentLoadFailed: (fail) {
                  log(fail.toString());
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<int> _getpdf() async {
    pdf = await EstanteriaDB.instance.traer(widget.id);
    isTemporal = pdf.isTemporal;
    return 1;
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
        (isTemporal)
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
                    Text('Guardar',style: TextStyle(fontSize: 10),)
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
              Text('ver Ubicacion.',style: TextStyle(fontSize: 12),)
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
              Text('Eliminar.',style: TextStyle(fontSize: 12),)
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
    pdf = await EstanteriaDB.instance.traer(widget.id);
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
