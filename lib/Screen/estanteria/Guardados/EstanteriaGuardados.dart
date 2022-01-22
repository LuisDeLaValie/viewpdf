import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:viewpdf/Screen/estanteria/widget/Libro/LibroEstatnteria.dart';
import 'package:viewpdf/Screen/estanteria/widget/NoLibro.dart';
import 'package:viewpdf/db/EstanteriaHive.dart';
import 'package:viewpdf/model/EstanteriaModel.dart';
import 'package:viewpdf/providers/EstanteriaProvider.dart';
import 'package:viewpdf/providers/SelectProvider.dart';

class EstanteriaGuardados extends StatelessWidget {
  const EstanteriaGuardados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EstanteriaProvider>(context);

    final pro2 = Provider.of<SelectProvider>(context);

    return ValueListenableBuilder<Box<EstanteriaModel>>(
        valueListenable: Hive.box<EstanteriaModel>(EstanteriaHive.instance.name)
            .listenable(),
        builder: (context, box, widget) {
          var libros = box.values;
          pro.guardadosKesy.clear();

          if (libros.length == 0) {
            return Center(
              child: NoLibro(),
            );
          } else {
            return GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 1.5,
              mainAxisSpacing: 1.5,
              childAspectRatio: 0.6,
              children: libros.map((e) {
                String key = e.key;
                final sel = pro2.listaSelects.contains(key);
                pro.guardadosKesy.add(key);
                print(e);
                return LibroEstatnteria(
                  item: e.libros[0],
                  slect: sel,
                  kei: key,
                  nombre: e.nombre,
                );
              }).toList(),
            );
          }
        });
  }
}
