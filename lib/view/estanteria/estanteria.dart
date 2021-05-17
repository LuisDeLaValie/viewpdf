import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';
import 'package:viewPDF/DB/ListaData.dart';
import 'package:viewPDF/model/PDFModel.dart';
import 'package:viewPDF/providers/EstanteriaProvider.dart';
import 'package:viewPDF/view/estanteria/widget/ElemntoEstanteria.dart';
import '../PDFVIEW/MyPdfView.dart';

import 'package:provider/provider.dart';

class EstanteriaScreen extends StatelessWidget {
  const EstanteriaScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EstanteriaProvider>(
            create: (_) => EstanteriaProvider()),
      ],
      child: _EstanteriaProvider(),
    );
  }
}

class _EstanteriaProvider extends StatelessWidget {
  const _EstanteriaProvider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EstanteriaProvider>(context);
    return _EstanteriaScreen(provider);
  }
}

class _EstanteriaScreen extends StatefulWidget {
  final EstanteriaProvider provider;
  const _EstanteriaScreen(this.provider, {Key key}) : super(key: key);

  @override
  __EstanteriaScreenState createState() => __EstanteriaScreenState();
}

class __EstanteriaScreenState extends State<_EstanteriaScreen> {
  Finder ordenar;
  @override
  void initState() {
    super.initState();
    widget.provider.init();
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
      body: FutureBuilder<List<PDFModel>>(
        future: EstanteriaDB.instance.listar(finder: ordenar),
        builder:
            (BuildContext context, AsyncSnapshot<List<PDFModel>> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<PDFModel> lista = snapshot.data;

            return Container(
              child: ListView.builder(
                itemCount: lista.length ?? 0,
                itemBuilder: (__, i) => EstanteriaAparador(item: lista[i]),
              ),
            );
          }
        },
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
      allowMultiple: true,
      allowedExtensions: ['pdf'],
    );

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
        widget.provider.ordernarFiltrar();
      }
    }
  }

  Widget myPopMenu() {
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 1) {
          widget.provider.limpiarlista();
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
}
