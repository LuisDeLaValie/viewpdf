import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:viewPDF/DB/ListaData.dart';
import 'package:viewPDF/model/PDFModel.dart';
import 'package:viewPDF/providers/EstanteriaProvider.dart';
import '../PDFVIEW/MyPdfView.dart';

import 'package:provider/provider.dart';

import 'menu.dart';
import 'widget/ElemntoEstanteria.dart';

class EstanteriaScreen extends StatelessWidget {
  const EstanteriaScreen({Key? key}) : super(key: key);

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
  const _EstanteriaProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EstanteriaProvider>(context);
    return _EstanteriaScreen(provider);
  }
}

class _EstanteriaScreen extends StatefulWidget {
  final EstanteriaProvider provider;
  const _EstanteriaScreen(this.provider, {Key? key}) : super(key: key);

  @override
  __EstanteriaScreenState createState() => __EstanteriaScreenState();
}

class __EstanteriaScreenState extends State<_EstanteriaScreen> {
  Finder? ordenar;
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
          Menu(),
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
            List<PDFModel>? lista = snapshot.data;

            return Container(
                child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 2,
              // Generate 100 widgets that display their index in the List.
              children: lista!.map((e) => EstanteriaAparador(item: e)).toList(),
            )

                // ListView.builder(
                //   itemCount: lista!.length,
                //   itemBuilder: (__, i) => Container(width: 80, child: EstanteriaAparador(item: lista[i])),
                // ),
                );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await widget.provider.getPDF();
          widget.provider.ordernarFiltrar();
          if (res['actualizar']) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyPDF(pdf: res['pdf'])),
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
