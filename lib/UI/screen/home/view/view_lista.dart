
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:viewpdf/UI/screen/home/widget/portada_libro.dart';
import 'package:viewpdf/model/libros_model.dart';

import '../../../../model/colecion_model.dart';
import '../../../../model/estanteria_model.dart';
import '../../../../provider/home_provider.dart';

class ViewLista extends StatelessWidget {
  const ViewLista({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var esta = context.select<HomeProvider, List<EstanteriaModel>>(
        (HomeProvider p) => p.estanteria);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: esta.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (_, key) {
          var data = esta[key];
          if (data is LibrosModel) {
            return PortadaLibro(
              titulo: data.titulo,
              portada: data.portada,
            );
          } else if (data is ColecionModel) {
            return PortadaLibro(
              titulo: data.titulo,
              portada: "",
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
