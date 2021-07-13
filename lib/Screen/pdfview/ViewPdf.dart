import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:viewPDF/model/PDFModel.dart';

class ViewPdf extends StatefulWidget {
  final PDFModel pdf;
  const ViewPdf({Key? key, required this.pdf}) : super(key: key);

  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  PdfViewerController? controller;

  @override
  Widget build(BuildContext context) {
    return PdfViewer.openFile(
      this.widget.pdf.path!,
      params: PdfViewerParams(
        padding: 8.0,
        minScale: 1.0,
       
        pageDecoration: BoxDecoration(
          color: Colors.yellow,
        ),
      ),
    );
  }
}
