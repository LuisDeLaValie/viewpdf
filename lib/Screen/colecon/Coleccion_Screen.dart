import 'package:flutter/material.dart';
import 'package:viewpdf/Colors/ColorA.dart';
import 'package:viewpdf/Screen/pdfview/MyPDFScreen.dart';
import 'package:viewpdf/db/EstanteriaHive.dart';
import 'package:viewpdf/model/EstanteriaModel.dart';

import '../CurpoGeneral.dart';
import 'header.dart';

class ColeccionScreen extends StatefulWidget {
  final String kei;
  const ColeccionScreen({Key? key, required this.kei}) : super(key: key);

  @override
  State<ColeccionScreen> createState() => _ColeccionScreenState();
}

class _ColeccionScreenState extends State<ColeccionScreen> {
  late EstanteriaModel estanteria;
  @override
  void initState() {
    super.initState();
    estanteria = EstanteriaHive.instance.box.get(widget.kei)!;
  }

  var librosaux;
  @override
  Widget build(BuildContext context) {
    var libros = estanteria.libros;
    print("lirbos : ${libros.length}");
    return CurpoGeneral(
      titulo: 'Coleccion',
      actions: [
        IconButton(
          icon: Icon(
            Icons.edit,
            color: ColorA.burntSienna,
          ),
          onPressed: () {},
        ),
      ],
      body: Column(
        children: [
          Header(
            title: estanteria.nombre,
            path: libros[0].path,
          ),
          Expanded(
            child: ReorderableListView.builder(
              itemCount: 3, //libros.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final libro = libros.removeAt(oldIndex);
                  libros.insert(newIndex, libro);
                });
              },
              proxyDecorator: (w, s, d) {
                var lib = libros[s];
                return Material(
                  child: ListTile(
                    key: Key(lib.id),
                    title: Text(lib.name),
                    tileColor: ColorA.lightCyan,
                  ),
                );
              },
              itemBuilder: (context, index) {
                var lib = libros[index];
                return Container(
                  key: Key(lib.id),
                  color: ColorA.paleCerulean,
                  margin: EdgeInsets.all(1),
                  child: ListTile(
                    title: Text(lib.name.split(".")[0]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyPDFScreen(pdf: lib)),
                      );
                    },
                    
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
