import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/Screen/pdfview/MyPDFScreen.dart';
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
                      onPressed: () {
                        final lis = proSelect.listaSelects;
                        crearColeccion(lis, context);
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

  void crearColeccion(List<String> lista, BuildContext context) {
    final iscolection =
        lista.map((e) => e.split('-').contains('Esta')).toList();

    if (iscolection.contains(true)) {
      print('es coleccion');
    } else {
      // Libros.crearColeccion(lista);
      showDialog(
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
    return AlertDialog(
      title: Text('Crear coleccion'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Seleccione un nombre para la coleccion'),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nombre de la colecion',
            ),
            onChanged: (e) {
              print(e);
            },
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

            print("nombre: ${controller.text} :: lista: $lista");
          },
        ),
      ],
    );
  }
}
