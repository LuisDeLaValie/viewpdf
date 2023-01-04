import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:viewpdf/UI/shared/layout/layout_home.dart';
import 'package:viewpdf/api/biblioteca_api.dart';
import 'package:viewpdf/model/libros_model.dart';

import 'view/formulario_view.dart';
import 'widget/labes_widgets.dart';

class DetallesScreenWeb extends StatefulWidget {
  final String id;
  const DetallesScreenWeb({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DetallesScreenWeb> createState() => _DetallesScreenWebState();
}

class _DetallesScreenWebState extends State<DetallesScreenWeb> {
  LibrosModel? libro;
  @override
  void initState() {
    super.initState();
    libro = LibrosDb.getBox().get(widget.id);
    actualizar();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutHome(
      titulo: "Detalles de ${libro?.titulo}",
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(25),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Imagen
                      Container(
                        color: Colors.black,
                        width: 250,
                        height: 370,
                      ),
                      SizedBox(width: 20),
                      // Datos
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              libro?.titulo ?? "",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: 50),
                            if (libro?.sinopsis != null) ...[
                              Text(
                                libro?.sinopsis ?? "",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(height: 20),
                            ],
                            if ((libro?.autores ?? []).length != 0)
                              LabesWidgets(
                                titulo: "Autor",
                                value: libro?.autores
                                        ?.map((e) => e.nombre)
                                        .join(", ") ??
                                    "",
                              ),
                            if (libro?.editorail != null)
                              LabesWidgets(
                                titulo: "Editorail",
                                value: libro?.editorail ?? "",
                              ),
                            if (libro?.paginacion != null)
                              LabesWidgets(
                                titulo: "Paginas",
                                value: "${libro?.paginacion?.end ?? 0} paginas",
                              ),
                            if (libro?.origen != null)
                              LabesWidgets(
                                titulo: "Origen",
                                value: libro?.origen?.nombre ?? "",
                                uri: Uri.parse(libro?.origen?.url ?? ""),
                              ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    launchUrl(
                                      Uri.parse(libro?.ver ?? ""),
                                    );
                                  },
                                  child: Text("Ver"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    launchUrl(
                                      Uri.parse(libro?.descargar ?? ""),
                                    );
                                  },
                                  child: Text("Descargar"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Imagen
                      Container(
                        color: Colors.black,
                        width: 250,
                        height: 370,
                      ),
                      SizedBox(width: 20),
                      // Datos
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: FormularioView(libro: libro!),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void actualizar() async {
    var res = await BibliotecaApi().get('/libros/${widget.id}', null);
    libro = LibrosModel.fromApi(res);
    libro?.save();
    setState(() {});
  }
}
