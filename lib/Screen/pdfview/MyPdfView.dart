import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:viewpdf/DB/ListaData.dart';
import 'package:viewpdf/Screen/pdfview/page.dart';

import 'package:viewpdf/model/PDFModel.dart';
import 'package:viewpdf/providers/PDFProvider.dart';
import 'zoom.dart';

import 'package:provider/provider.dart';

class MyPDFScreen extends StatelessWidget {
  final PDFModel pdf;
  const MyPDFScreen({Key? key, required this.pdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PDFProvider>(create: (_) => PDFProvider()),
      ],
      child: _MyPDFProvider(
        pdf: pdf,
      ),
    );
  }
}

class _MyPDFProvider extends StatelessWidget {
  final PDFModel pdf;
  const _MyPDFProvider({Key? key, required this.pdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PDFProvider>(context);
    return _MyPDFScreen(provider, pdf: pdf);
  }
}

class _MyPDFScreen extends StatefulWidget {
  final PDFProvider provider;
  final PDFModel pdf;
  const _MyPDFScreen(this.provider, {Key? key, required this.pdf})
      : super(key: key);

  @override
  __MyPDFScreenState createState() => __MyPDFScreenState();
}

class __MyPDFScreenState extends State<_MyPDFScreen> {
  PdfViewerController? pdfViewController;

  @override
  void initState() {
    widget.provider.init(widget.pdf);

    pdfViewController = PdfViewerController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (pdfViewController!.pageNumber != widget.provider.page)
      pdfViewController!.jumpToPage(widget.provider.page);
    if (pdfViewController!.zoomLevel != widget.provider.zoom)
      pdfViewController!.zoomLevel = widget.provider.zoom;

    return Scaffold(
      appBar: AppBar(
        title: LaPage(),
        actions: [ZoomPage(), myPopMenu()],
      ),
      body: SfPdfViewer.file(
        File(widget.pdf.path!),
        initialZoomLevel: widget.provider.zoom,
        controller: pdfViewController,
        onPageChanged: (chane) {
          widget.provider.actualizar(page: chane.newPageNumber);
          log("onPageChanged :: " + "${chane.newPageNumber}");
        },
        onDocumentLoaded: (load) {
          widget.provider.allPage = pdfViewController!.pageCount;
          log("onDocumentLoaded :: " + load.toString());
        },
        onDocumentLoadFailed: (fail) {
          log("onDocumentLoadFailed :: " + fail.toString());
        },
        onTextSelectionChanged: (asa) {
          log("onTextSelectionChanged :: " + asa.toString());
        },
        onZoomLevelChanged: (ash) {
          widget.provider.actualizar(zoom: ash.newZoomLevel);
          log("ZOOM :: " + pdfViewController!.zoomLevel.toString());
        },
      ),
    );
  }

  Widget myPopMenu() {
    return PopupMenuButton(
      onSelected: (dynamic value) {
        if (value == 1) {
          widget.provider.guardarpdf();
        } else if (value == 2) {
          showMyDialog();
        } else if (value == 3) {
          widget.provider.eliminar();
        }
      },
      itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
        if (widget.pdf.isTemporal!)
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

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Path del archivo.'),
          content: Text(widget.pdf.path!),
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
