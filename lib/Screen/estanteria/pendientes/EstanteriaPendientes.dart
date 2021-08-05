import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/Screen/CurpoGeneral.dart';

import 'package:viewpdf/Screen/estanteria/widget/Libro/LibroEstatnteria.dart';
import 'package:viewpdf/Screen/estanteria/widget/Menu/menu.dart';
import 'package:viewpdf/Screen/estanteria/widget/NoLibro.dart';
import 'package:viewpdf/model/PDFModel.dart';
import 'package:viewpdf/providers/EstanteriaProvider.dart';

class EstanteriaPendientes extends StatelessWidget {
  final List<PDFModel>? lista;
  const EstanteriaPendientes({Key? key, required this.lista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EstanteriaProvider>(context);
    if (lista == null || lista!.length == 0)
      return NoLibro(
        onRefres: () {
          pro.listarpendiens();
        },
      );

    return CurpoGeneral(
      body: Container(
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 1.5,
          mainAxisSpacing: 1.5,
          childAspectRatio: 0.6,
          children: lista!
              .map((e) => LibroEstatnteria(
                    item: e,
                    onBack: () {
                      pro.listarpendiens();
                    },
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: OptionsPendientes(),
    );
  }
}
