import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewPDF/Screen/pdfview/MyPdfView.dart';
import 'package:viewPDF/model/PDFModel.dart';
import 'package:viewPDF/providers/EstanteriaProvider.dart';

class EstanteriaAparador extends StatelessWidget {
  final PDFModel item;
  const EstanteriaAparador({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EstanteriaProvider>(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final size = constraints.smallest;

        return InkWell(
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
                width: size.width,
                height: size.height * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(item.portada!)),
                  ), // NetworkImage('Path to your image')),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.2,
                child: Text(
                  item.name!,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        );
      },
    );

    // return ListTile(
    //   title: Text(item.name),
    //   onTap: () {
    //     pro.actualizarPDF(item);
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => MyPDF(pdf: item),
    //       ),
    //     );
    //     //     .then((value) {
    //     //   pro.ordenarasendente();
    //     // });
    //   },
    //   trailing: (item.isTemporal) ? Etiqueta(texto: "Temporal") : null,
    // );
  }
}
