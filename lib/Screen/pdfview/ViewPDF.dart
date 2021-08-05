import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:viewpdf/providers/PDFProvider.dart';

class ViewPDF extends StatelessWidget {
  final PdfViewerController pdfViewController;
  final void Function() loader;
  ViewPDF({Key? key, required this.pdfViewController, required this.loader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<PDFProvider>(context);

    return SfPdfViewer.file(
      File(pro.pdf.path),
      canShowScrollHead: false,
      controller: pdfViewController,
      onPageChanged: (chane) {
        log("onPageChanged :: ${chane.newPageNumber}");
        pro.page = chane.newPageNumber;
      },
      onDocumentLoaded: (load) {
        pro.allPage = pdfViewController.pageCount;
        log("onDocumentLoaded :: ${load.toString()}");
      },
      onDocumentLoadFailed: (fail) {
        log("onDocumentLoadFailed :: ${fail.toString()}");
      },
      onTextSelectionChanged: (asa) {
        log("onTextSelectionChanged :: ${asa.toString()}");
      },
      onZoomLevelChanged: (ash) {
        log("ZOOM :: ${ash.newZoomLevel}");
        pro.zoom = ash.newZoomLevel;
      },
    );
  }
}
