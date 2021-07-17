import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/Screen/pdfview/MyPdfView.dart';
import 'package:viewpdf/model/PDFModel.dart';
import 'package:viewpdf/providers/EstanteriaProvider.dart';

class EstanteriaAparador extends StatelessWidget {
  final PDFModel item;
  const EstanteriaAparador({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EstanteriaProvider>(context);
    final width = 100.0;
    final heigth = 170.0;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: InkWell(
        onDoubleTap: () {
          onSelected(pro);
        },
        onTap: () {
          if (item.isSelect) {
            onSelected(pro);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyPDFScreen(pdf: item)),
            ).then((value) {
              pro.actualizarPDF(item);
            });
          }
        },
        child: Container(
          decoration: (item.isSelect)
              ? BoxDecoration(
                  color: Colors.green.withOpacity(0.4),
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                )
              : null,
          child: Column(
            children: [
              Container(
                width: width,
                height: heigth * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(item.portada!)),
                  ), // NetworkImage('Path to your image')),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
              Container(
                width: width,
                height: heigth * 0.2,
                child: Text(
                  item.name!,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSelected(EstanteriaProvider pro) {
    final id = pro.pendientes
        .indexWhere((element) => element.hashCode == item.hashCode);
    if (id != -1) {
      pro.pendientes[id].isSelect = !item.isSelect;
      pro.pendientes = pro.pendientes;
    } else {
      final id =
          pro.lista.indexWhere((element) => element.hashCode == item.hashCode);
      pro.lista[id].isSelect = !item.isSelect;
      pro.lista = pro.lista;
    }
  }
}
