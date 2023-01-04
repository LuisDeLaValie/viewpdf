import 'package:flutter/material.dart';

import 'package:viewpdf/model/libros_model.dart';

class FormularioView extends StatefulWidget {
  final LibrosModel libro;

  const FormularioView({
    Key? key,
    required this.libro,
  }) : super(key: key);

  @override
  State<FormularioView> createState() => _FormularioViewState();
}

class _FormularioViewState extends State<FormularioView> {
  int nAutor = 1;

  @override
  Widget build(BuildContext context) {
    nAutor = (widget.libro.autores?.length ?? 0) + 1;
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                initialValue: widget.libro.titulo,
                decoration: InputDecoration(labelText: "Titulo"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                initialValue: widget.libro.sinopsis,
                maxLines: 3,
                decoration: InputDecoration(labelText: "Sinopsis"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Autores"),
                      IconButton(
                        iconSize: 20,
                        splashRadius: 20,
                        onPressed: () {
                          setState(() {
                            nAutor++;
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  ...{
                    for (int i = 0; i < nAutor; i++)
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          initialValue: ((nAutor - 1) <= i)
                              ? null
                              : widget.libro.autores?[i].nombre,
                          decoration: InputDecoration(labelText: "Autor"),
                        ),
                      ),
                  }.toList()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: widget.libro.paginacion?.end.toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Paginas"),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      initialValue: widget.libro.editorail,
                      decoration: InputDecoration(labelText: "Editorial"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Origen"),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            initialValue: widget.libro.origen?.nombre,
                            decoration: InputDecoration(labelText: "Nombre"),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            initialValue: widget.libro.origen?.url,
                            decoration: InputDecoration(labelText: "Url"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
