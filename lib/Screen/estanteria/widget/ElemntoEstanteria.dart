import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thumbnailer/thumbnailer.dart';
import 'package:viewPDF/Screen/pdfview/MyPdfView.dart';
import 'package:viewPDF/Screen/pdfview/ViewPdf.dart';
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
        final size = constraints.smallest.width;

        return Material(
          borderRadius: BorderRadius.circular(25),
          elevation: 5,
          child: InkWell(
            onTap: () {
              pro.actualizarPDF(item);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewPdf(pdf: item),
                ),
              );
            },
            child: Column(
              mainAxisSize:MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Thumbnail(
                    mimeType: 'application/pdf',
                    widgetSize: size,
                    dataResolver: () => File(item.path!).readAsBytes(),
                    onlyName: true,
                    // useWrapper: false,
                    onlyIcon: false,
                    name: item.name,
                    useWaterMark: false,
                  ),
                ),
              ],
            ),
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
