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
        onTap: () {
          pro.actualizarPDF(item);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyPDF(pdf: item)),
          );
        },
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
    );
  }
}
