import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:viewpdf/Screen/estanteria/widget/Libro/LibroEstatnteria.dart';
import 'package:viewpdf/Screen/estanteria/widget/NoLibro.dart';
import 'package:viewpdf/providers/EstanteriaProvider.dart';
import 'package:viewpdf/providers/SelectProvider.dart';

class EstanteriaGuardados extends StatelessWidget {
  const EstanteriaGuardados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EstanteriaProvider>(context);
    final pro2 = Provider.of<SelectProvider>(context);

    if (pro.guardados == null || pro.guardados!.length == 0)
      return Center(
        child: NoLibro(
          onRefres: () {
            pro.listarguardados();
          },
        ),
      );
    int key = 0;
    return RefreshIndicator(
      onRefresh: () async {
        await pro.listarguardados();
      },
      child: Container(
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 1.5,
          mainAxisSpacing: 1.5,
          childAspectRatio: 0.6,
          children: pro.guardados!.map((e) {
            final sel = pro2.listaSelects
                .indexWhere((element) => element!.index == key);

            final li = LibroEstatnteria(
              item: e,
              onBack: () {
                pro.listarguardados();
              },
              index: key,
              slect: sel > -1,
            );
            key++;
            return li;
          }).toList(),
        ),
      ),
    );
  }
}
