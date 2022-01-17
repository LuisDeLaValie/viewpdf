import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:viewpdf/Colors/ColorA.dart';
import 'package:viewpdf/Screen/pdfview/ViewPDF.dart';

import 'package:viewpdf/Screen/pdfview/page.dart';
import 'package:viewpdf/model/PDFModel.dart';
import 'package:viewpdf/providers/PDFProvider.dart';

import 'zoom.dart';

class MyPDFScreen extends StatelessWidget {
  final PDFModel pdf;
  const MyPDFScreen({Key? key, required this.pdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PDFProvider>(create: (_) => PDFProvider()),
      ],
      child: _MyPDFProvider(pdf: pdf),
    );
  }
}

class _MyPDFProvider extends StatelessWidget {
  final PDFModel pdf;
  const _MyPDFProvider({Key? key, required this.pdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PDFProvider>(context);

    return _MyPDFScreen(provider: provider, pdf: pdf);
  }
}

class _MyPDFScreen extends StatefulWidget {
  final PDFProvider provider;
  final PDFModel pdf;

  const _MyPDFScreen({Key? key, required this.provider, required this.pdf})
      : super(key: key);

  @override
  __MyPDFScreenState createState() => __MyPDFScreenState();
}

class __MyPDFScreenState extends State<_MyPDFScreen> {
  bool jumpTo = false, pageNavigate = false, primero = true;
  @override
  void initState() {
    widget.provider.init(widget.pdf);
    controller.addListener(({property}) {
      if (!jumpTo && property == "jumpTo") jumpTo = true;
      if (!pageNavigate && property == "pageNavigate") pageNavigate = true;
      if (primero && jumpTo && pageNavigate) {
        primero = false;
        Future.delayed(Duration(microseconds: 100000), () {
          controller.zoomLevel = widget.pdf.zoom;
          controller.jumpToPage(widget.pdf.page);
        });
      }
    });
    super.initState();
  }

  final controller = PdfViewerController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await widget.provider.actualizar();
        // Navigator.pop(context, widget.provider.pdf);
        return true;
      },
      child: RawKeyboardListener(
        autofocus:true,
        focusNode: FocusNode(),
        onKey: (val) {
          print("OnKey");
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorA.bdazzledBlue,
            title: LaPage(
              onPageChanged: (int) {
                controller.jumpToPage(int);
              },
            ),
            actions: [
              ZoomPage(
                onZoomChanged: (double zoom) {
                  controller.zoomLevel = zoom;
                },
              ),
              myPopMenu()
            ],
          ),
          body: ViewPDF(
            pdfViewController: controller,
            loader: () {
              // controller.jumpToPage(widget.pdf.page);
            },
          ),
        ),
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
        if (widget.provider.pdf.isTemporal)
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
          content: Text(widget.provider.pdf.path),
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
