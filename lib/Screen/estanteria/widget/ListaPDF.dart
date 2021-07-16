import 'package:flutter/material.dart';
import 'package:viewpdf/Screen/estanteria/widget/ElemntoEstanteria.dart';
import 'package:viewpdf/model/PDFModel.dart';

class ListaPDF extends StatelessWidget {
  final List<PDFModel> lista;
  final Orientation orientation;
  const ListaPDF({Key? key, required this.lista, required this.orientation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pres = Text(
      "Guardados",
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'Georgia',
      ),
    );

    final lalist = Wrap(
      alignment: WrapAlignment.start,
      children: lista.map((e) => EstanteriaAparador(item: e)).toList(),
    );

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pres,
          (orientation == Orientation.portrait)
              ? Expanded(child: SingleChildScrollView(child: lalist))
              : lalist,
        ],
      ),
    );
  }
}
