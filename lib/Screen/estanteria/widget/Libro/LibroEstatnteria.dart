import 'package:flutter/material.dart';

import 'package:viewpdf/Screen/estanteria/widget/Libro/portada.dart';
import 'package:viewpdf/Screen/estanteria/widget/Libro/titulo.dart';
import 'package:viewpdf/Screen/pdfview/MyPDFScreen.dart';
import 'package:viewpdf/model/PDFModel.dart';

class LibroEstatnteria extends StatelessWidget {
  final PDFModel item;
  final Function() onBack;
  const LibroEstatnteria({Key? key, required this.item, required this.onBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 190,
      margin: EdgeInsets.all(3.56),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyPDFScreen(pdf: item)),
          ).then((value) {
            onBack();
          });
        },
        child: Column(
          children: [
            Expanded(child: Portada(path: item.portada)),
            Titulo(titulo: item.name),
          ],
        ),
      ),
    );
  }
}
