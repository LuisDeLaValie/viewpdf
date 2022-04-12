import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/Colors/ColorA.dart';
import 'package:viewpdf/Screen/pdfview/MyPDFScreen.dart';

import 'package:viewpdf/model/EstanteriaModel.dart';
import 'package:viewpdf/model/PDFModel.dart';
import 'package:viewpdf/providers/Editar_colecion.dart';
import 'package:viewpdf/services/libros.dart';

class ListasColections extends StatefulWidget {
  final EstanteriaModel estanteria;

  const ListasColections({
    Key? key,
    required this.estanteria,
  }) : super(key: key);

  @override
  State<ListasColections> createState() => _ListasColectionsState();
}

class _ListasColectionsState extends State<ListasColections> {
  List<PDFModel> libros = [];
  @override
  void initState() {
    super.initState();
    libros = widget.estanteria.libros;
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EditarColecionProvider>(context);
    return pro.onEdit ? edit() : nornal();
  }

  Widget edit() {
    return ReorderableListView.builder(
      itemCount: widget.estanteria.libros.length,
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        setState(() {
          final libro = widget.estanteria.libros.removeAt(oldIndex);
          widget.estanteria.libros.insert(newIndex, libro);
        });
      },
      proxyDecorator: (w, s, d) {
        var lib = widget.estanteria.libros[s];
        return Material(
          child: _item(lib),
        );
      },
      itemBuilder: (context, index) {
        var lib = widget.estanteria.libros[index];
        return Container(
          key: Key(lib.id),
          decoration: BoxDecoration(
            color: ColorA.paleCerulean,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.all(1),
          child: _item(
            lib,
            IconButton(
              icon: Icon(
                Icons.delete_sweep,
                color: ColorA.burntSienna,
              ),
              onPressed: () {
                if ((widget.estanteria.libros.length - 1) == 1) {
                  Libros().eliminarColeccion([widget.estanteria.id]);
                  Navigator.pop(context);
                } else {
                  Libros().eliminarLibroColeccion(
                      widget.estanteria.id, widget.estanteria.libros[index].id);
                  setState(() {
                    widget.estanteria.libros.removeAt(index);
                  });
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _item(PDFModel libro, [Widget? trailing]) {
    return ListTile(
      tileColor: ColorA.paleCerulean,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: ColorA.bdazzledBlue, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      title: Text(libro.name.replaceAll('.pdf', '').replaceAll('.PDF', '')),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyPDFScreen(pdf: libro)),
        );
      },
      trailing: trailing,
    );
  }

  Widget nornal() {
    return ListView.builder(
      itemCount: widget.estanteria.libros.length,
      itemBuilder: (context, index) {
        var libro = widget.estanteria.libros[index];
        return _item(libro);
      },
    );
  }
}
