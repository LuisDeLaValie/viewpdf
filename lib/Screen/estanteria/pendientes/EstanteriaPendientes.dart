import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:viewpdf/Screen/estanteria/widget/Libro/LibroEstatnteria.dart';
import 'package:viewpdf/Screen/estanteria/widget/NoLibro.dart';
import 'package:viewpdf/db/Libro_hive.dart';
import 'package:viewpdf/model/PDFModel.dart';
import 'package:viewpdf/providers/EstanteriaProvider.dart';
import 'package:viewpdf/providers/SelectProvider.dart';

class EstanteriaPendientes extends StatelessWidget {
  const EstanteriaPendientes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EstanteriaProvider>(context);

    final pro2 = Provider.of<SelectProvider>(context);

    return ValueListenableBuilder<Box<PDFModel>>(
      valueListenable: Hive.box<PDFModel>(LibroHive.instance.name).listenable(),
      builder: (context, box, widget) {
        var list = box.values.where((element) => element.isTemporal).toList();
        pro.pendienteKes = box.keys.cast<String>().toList();

        if (list.length == 0) {
          return Center(
            child: NoLibro(),
          );
        } else {
          return _Lista(list: list);
        }
      },
    );
  }
}

class _Lista extends StatelessWidget {
  const _Lista({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<PDFModel> list;

  @override
  Widget build(BuildContext context) {
    final pro2 = Provider.of<SelectProvider>(context);
    var selectlist = pro2.listaSelects;

    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 1.5,
      mainAxisSpacing: 1.5,
      childAspectRatio: 0.6,
      children: list.map((e) {
        final sel = selectlist.contains(e.id);
        return LibroEstatnteria(
          item: e,
          slect: sel,
          kei: e.key,
          nombre: e.name,
        );
      }).toList(),
    );
  }
}
