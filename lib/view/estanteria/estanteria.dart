import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:gx_file_picker/gx_file_picker.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';
import 'package:viewPDF/data/ListaData.dart';
import '../PDFVIEW/MyPdfView.dart';
import 'widget/etiquetea.dart';

class Stanteria extends StatefulWidget {
  const Stanteria({Key key}) : super(key: key);

  @override
  _StanteriaState createState() => _StanteriaState();
}

class _StanteriaState extends State<Stanteria> {
  Finder ordenar;
  @override
  void initState() {
    super.initState();
    ordenarasendente();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
        actions: [
          myPopMenu(),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            FutureBuilder<List<PDFModel>>(
              future: EstanteriaDB.instance.listar(finder: ordenar),
              builder: (BuildContext context,
                  AsyncSnapshot<List<PDFModel>> snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<PDFModel> lista = snapshot.data;

                  return Container(
                    height: MediaQuery.of(context).size.height - 150,
                    child: ListView.builder(
                      itemCount: lista.length ?? 0,
                      itemBuilder: (__, i) => ListTile(
                        title: Text(lista[i].name),
                        onTap: () {
                          lista[i].actualizado = Timestamp.now();

                          // lista[i].isTemporal = false;
                          EstanteriaDB.instance.actualizar(lista[i]);
                          Navigator.push(
                            this.context,
                            MaterialPageRoute(
                              builder: (context) => MyPDF(
                                pdf: lista[i],
                              ),
                            ),
                          ).then((value) {
                            ordenarasendente();
                            setState(() {});
                          });
                        },
                        trailing: (lista[i].isTemporal)
                            ? Etiqueta(
                                texto: "Temporal",
                              )
                            : null,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getPDF();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void getPDF() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    // File file = await FilePicker.getFile(
    //     type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      PDFModel pdf;
      for (var file in result.files) {
        pdf = await EstanteriaDB.instance.add(PDFModel(
          page: 0,
          path: file.path,
          name: file.name,
          actualizado: Timestamp.now(),
        ));
      }
      if (result.paths.length == 1) {
        Navigator.push(
          this.context,
          MaterialPageRoute(builder: (context) => MyPDF(pdf: pdf)),
        ).then((value) {});
      } else {
        ordenarasendente();
        setState(() {});
      }
    }
  }

  void ordenarasendente() {
    ordenar = Finder(sortOrders: [
      SortOrder('isTemporal', false),
      SortOrder('actualizado', false),
    ]);
  }

  Widget myPopMenu() {
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 1) {
          limpiarlista();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                child: Icon(
                  Icons.clear_all_outlined,
                  color: Colors.grey,
                ),
              ),
              Text('Limpiar.')
            ],
          ),
        ),
      ],
    );
  }

  void limpiarlista() {
    EstanteriaDB.instance
        .eliminar(
      finder: Finder(
        filter: Filter.equals('isTemporal', true),
      ),
    )
        .then((value) {
      setState(() {});
    });
  }
}
