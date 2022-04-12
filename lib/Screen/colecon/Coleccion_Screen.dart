import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:viewpdf/Colors/ColorA.dart';
import 'package:viewpdf/Screen/colecon/listas_colections.dart';
import 'package:viewpdf/db/EstanteriaHive.dart';
import 'package:viewpdf/model/EstanteriaModel.dart';
import 'package:viewpdf/providers/Editar_colecion.dart';

import '../CurpoGeneral.dart';
import 'header.dart';

class ColeccionScreen extends StatelessWidget {
  final String kei;

  const ColeccionScreen({Key? key, required this.kei}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EditarColecionProvider>(
            create: (_) => EditarColecionProvider()),
      ],
      child: _ColeccionScreen(kei: kei),
    );
  }
}

// ignore: must_be_immutable
class _ColeccionScreen extends StatelessWidget {
  _ColeccionScreen({Key? key, required String kei}) : super(key: key) {
    estanteria = EstanteriaHive.instance.box.get(kei)!;
  }

  late EstanteriaModel estanteria;

  var librosaux;
  @override
  Widget build(BuildContext context) {
    var libros = estanteria.libros;

    final pro = Provider.of<EditarColecionProvider>(context);

    return CurpoGeneral(
      titulo: 'Coleccion',
      actions: [
        IconButton(
          icon: Icon(
            pro.onEdit ? Icons.edit_off : Icons.edit,
            color: ColorA.burntSienna,
          ),
          onPressed: () {
            if (pro.onEdit) {
              estanteria.nombre = pro.nombre;
              estanteria.save();
            }

            pro.onEdit = !pro.onEdit;
          },
        ),
      ],
      body: Column(
        children: [
          Header(
            title: estanteria.nombre,
            path: libros[0].path,
          ),
          Expanded(
            child: ListasColections(estanteria: estanteria),
          ),
        ],
      ),
    );
  }
}
