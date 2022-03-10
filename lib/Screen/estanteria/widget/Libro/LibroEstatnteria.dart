import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:viewpdf/Colors/ColorA.dart';
import 'package:viewpdf/Screen/colecon/Coleccion_Screen.dart';
import 'package:viewpdf/Screen/estanteria/widget/Libro/portada.dart';
import 'package:viewpdf/Screen/estanteria/widget/Libro/titulo.dart';
import 'package:viewpdf/Screen/pdfview/MyPDFScreen.dart';
import 'package:viewpdf/model/PDFModel.dart';
import 'package:viewpdf/providers/SelectProvider.dart';

class LibroEstatnteria extends StatelessWidget {
  final String nombre;
  final String kei;
  final PDFModel item;
  final bool slect;
  final Function()? onBack;
  const LibroEstatnteria({
    Key? key,
    required this.item,
    required this.slect,
    this.onBack,
    required this.nombre,
    required this.kei,
  }) : super(key: key);

  void select() {}
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<SelectProvider>(context);
    return Container(
      width: 110,
      height: 190,
      margin: EdgeInsets.all(3.56),
      child: InkWell(
        onLongPress: !pro.isSelect
            ? () {
                pro.selcet(kei);
              }
            : null,
        onTap: () {
          if (pro.isSelect) {
            pro.selcet(kei);
          } else {
            showLibro(context);
          }
        },
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(child: Portada(path: item.path)),
                Titulo(titulo: nombre),
              ],
            ),
            if (slect)
              Container(
                color: ColorA.burntSienna.withOpacity(0.4),
              ),
          ],
        ),
      ),
    );
  }

  void showLibro(BuildContext context) async {
    bool iscolecion = kei.split("-").contains("Esta");
    if (iscolecion) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ColeccionScreen(kei: kei)),
      );
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyPDFScreen(pdf: item)),
      );
    }
    if (onBack != null) {
      onBack!();
    }
  }
}
