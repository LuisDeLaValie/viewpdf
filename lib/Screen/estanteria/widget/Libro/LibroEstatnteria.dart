import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:viewpdf/Colors/ColorA.dart';
import 'package:viewpdf/Screen/estanteria/widget/Anuncios.dart';
import 'package:viewpdf/Screen/estanteria/widget/Libro/portada.dart';
import 'package:viewpdf/Screen/estanteria/widget/Libro/titulo.dart';
import 'package:viewpdf/Screen/pdfview/MyPDFScreen.dart';
import 'package:viewpdf/model/PDFModel.dart';
import 'package:viewpdf/providers/SelectProvider.dart';

class LibroEstatnteria extends StatelessWidget {
  final PDFModel item;
  final int index;
  final bool slect;
  final Function() onBack;
  const LibroEstatnteria({
    Key? key,
    required this.item,
    required this.index,
    required this.slect,
    required this.onBack,
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
                pro.selcet(ItemSelect(index: index, key: item.id));
              }
            : null,
        onTap: () async {
          if (pro.isSelect) {
            pro.selcet(ItemSelect(index: index, key: item.id));
          } else {
            await Interstitial.instance.show();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyPDFScreen(pdf: item)),
            ).then((value) {
              onBack();
            });
          }
        },
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(child: Portada(path: item.path)),
                Titulo(titulo: item.name),
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
}
