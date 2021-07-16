import 'package:flutter/material.dart';
import 'package:viewpdf/Screen/estanteria/widget/ElemntoEstanteria.dart';
import 'package:viewpdf/model/PDFModel.dart';

class ListaPendiente extends StatelessWidget {
  final List<PDFModel> lista;
  final Orientation orientation;
  const ListaPendiente(
      {Key? key, required this.lista, required this.orientation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pres = Text(
      "Pendientes",
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'Georgia',
      ),
    );

    final lalist = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lista.map((e) => EstanteriaAparador(item: e)).toList(),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pres,
        (orientation == Orientation.portrait)
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: lalist,
              )
            : lalist,
      ],
    );
  }
}
