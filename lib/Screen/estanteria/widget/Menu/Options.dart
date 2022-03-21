import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:tdtxle_inputs_flutter/inputs_tdtxle.dart';
import 'package:viewpdf/Screen/pdfview/MyPDFScreen.dart';
import 'package:viewpdf/db/EstanteriaHive.dart';
import 'package:viewpdf/model/EstanteriaModel.dart';
import 'package:viewpdf/providers/EstanteriaProvider.dart';
import 'package:viewpdf/providers/SelectProvider.dart';
import 'package:viewpdf/services/libros.dart';

class OptionsPendientes extends StatelessWidget {
  const OptionsPendientes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EstanteriaProvider>(context);
    final proSelect = Provider.of<SelectProvider>(context);
    return BounceInDown(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: TextDirection.rtl,
        children: [
          //opciones generales
          Container(
            child: BounceInDown(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (pro.pendienteKes.length > 1)
                    BounceInRight(
                      child: FloatingActionButton(
                        onPressed: () async {
                          pro.limpiarlista();
                        },
                        child: Icon(Icons.clear_all_outlined),
                      ),
                    ),
                  FloatingActionButton(
                    onPressed: () async {
                      final res = await pro.getPDF();
                      if (res['actualizar']) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyPDFScreen(pdf: res['pdf'])),
                        );
                      }
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),

          if (proSelect.isSelect)
            Container(
              child: BounceInRight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      onPressed: () async {
                        final lis = proSelect.listaSelects;
                        await pro.guardarpdf(lis);
                        proSelect.cancel();
                      },
                      child: Icon(Icons.book_sharp),
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        final lis = proSelect.listaSelects;
                        await pro.limpiarlista(keys: lis);
                        proSelect.cancel();
                      },
                      child: Icon(Icons.clear),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class OptionsGuardados extends StatelessWidget {
  const OptionsGuardados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EstanteriaProvider>(context);
    final proSelect = Provider.of<SelectProvider>(context);
    return BounceInDown(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: TextDirection.rtl,
        children: [
          if (proSelect.isSelect)
            Container(
              child: BounceInRight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      onPressed: () async {
                        final lis = proSelect.listaSelects;
                        await crearColeccion(lis, context);
                        proSelect.cancel();
                      },
                      child: Icon(Icons.add_box),
                    ),
                    SizedBox(width: 10),
                    FloatingActionButton(
                      onPressed: () async {
                        final lis = proSelect.listaSelects;
                        await pro.limpiarlista(keys: lis);
                        proSelect.cancel();
                      },
                      child: Icon(Icons.delete_forever),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> crearColeccion(List<String> lista, BuildContext context) async {
    final iscolection =
        lista.map((e) => e.split('-').contains('Esta')).toList();

    if (iscolection.contains(true)) {
      print('es coleccion');
    } else {
      // Libros.crearColeccion(lista);
      await showDialog(
        context: context,
        builder: (context) {
          return _CrearColeccion(lista: lista);
        },
      );
    }
  }
}

class _CrearColeccion extends StatelessWidget {
  final List<String> lista;
  _CrearColeccion({Key? key, required this.lista}) : super(key: key);

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var estanteria = Hive.box<EstanteriaModel>(EstanteriaHive.instance.name);
    var coleccion = estanteria.values.where((e) => e.isColeection).toList();
    controller.text = estanteria.get(lista[0])?.nombre ?? "";

    return AlertDialog(
      title: Text('Crear coleccion'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Seleccione un nombre para la coleccion'),
          SelectField(
            settingsTextField: SelectFieldSettings(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nombre de la colecion',
              ),
            ),
            values: coleccion
                .map(
                  (e) => SelectItem(
                    value: e.key,
                    search: e.nombre,
                    title: Text(e.nombre),
                    onTap: () {
                      Libros().agregarLibros(e.key, lista);
                      Navigator.of(context).pop();
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Crear'),
          onPressed: () {
            Libros().crearColeccion(controller.text, lista);
            Navigator.of(context).pop();

            log("nombre: ${controller.text} :: lista: $lista");
          },
        ),
      ],
    );
  }
}
