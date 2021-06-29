import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thumbnailer/thumbnailer.dart';
import 'package:viewPDF/Screen/pdfview/MyPdfView.dart';
import 'package:viewPDF/model/PDFModel.dart';
import 'package:viewPDF/providers/EstanteriaProvider.dart';

import 'etiquetea.dart';

class EstanteriaAparador extends StatelessWidget {
  final PDFModel item;
  const EstanteriaAparador({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EstanteriaProvider>(context);

    return Thumbnail(
      dataResolver: () async {
        return (await DefaultAssetBundle.of(context).load(item.path))
            .buffer
            .asUint8List();
      },
      mimeType: 'image/png',
      widgetSize: 100,
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
