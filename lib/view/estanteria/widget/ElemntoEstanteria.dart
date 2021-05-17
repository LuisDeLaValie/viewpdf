import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewPDF/model/PDFModel.dart';
import 'package:viewPDF/providers/EstanteriaProvider.dart';
import 'package:viewPDF/view/pdfview/MyPdfView.dart';

import 'etiquetea.dart';

class EstanteriaAparador extends StatelessWidget {
  final PDFModel item;
  const EstanteriaAparador({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EstanteriaProvider>(context);
    return ListTile(
      title: Text(item.name),
      onTap: () {
        pro.actualizarPDF(item);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyPDF(pdf: item),
          ),
        );
        //     .then((value) {
        //   pro.ordenarasendente();
        // });
      },
      trailing: (item.isTemporal) ? Etiqueta(texto: "Temporal") : null,
    );
  }
}
