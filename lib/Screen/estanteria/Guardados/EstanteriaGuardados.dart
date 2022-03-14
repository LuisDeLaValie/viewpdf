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

    return ValueListenableBuilder<Box<EstanteriaModel>>(
        valueListenable: Hive.box<EstanteriaModel>(EstanteriaHive.instance.name)
            .listenable(),
        builder: (context, box, widget) {
          var libros = box.values;
          pro.guardadosKesy = box.keys.cast<String>().toList();
          // pro.guardadosKesy.clear();

          if (libros.length == 0) {
            return Center(
              child: NoLibro(),
            );
          } else {
            return _Listaaux(libros: libros.toList());
          }
        });
  }
}

class _Listaaux extends StatelessWidget {
  final List<EstanteriaModel> libros;
  const _Listaaux({
    Key? key,
    required this.libros,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro2 = Provider.of<SelectProvider>(context);
    var selectlist = pro2.listaSelects;

    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 1.5,
      mainAxisSpacing: 1.5,
      childAspectRatio: 0.6,
      children: libros.map((e) {
        String key = e.key;
        final sel = selectlist.contains(key);
        if (e.libros.length == 0) {
          e.delete();
        }
        return LibroEstatnteria(
          item: e.libros[0],
          slect: sel,
          kei: key,
          nombre: e.nombre,
        );
      }).toList(),
    );
  }
}
