import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sembast/sembast.dart';
import 'package:viewpdf/Screen/estanteria/widget/ListaPDF.dart';
import 'package:viewpdf/Screen/estanteria/widget/listaPendiente.dart';
import 'package:viewpdf/providers/EstanteriaProvider.dart';
import '../PDFVIEW/MyPdfView.dart';

import 'package:provider/provider.dart';

import 'menu.dart';

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
        title: Text('Biblioteca'),
        actions: [
          Menu(),
        ],
      ),
      body: OrientationBuilder(
        builder: (_, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.provider.pendientes.length > 0)
                  ListaPendiente(
                    lista: widget.provider.pendientes,
                    orientation: orientation,
                  ),
                if (widget.provider.lista.length > 0)
                  Expanded(
                    child: ListaPDF(
                      lista: widget.provider.lista,
                      orientation: orientation,
                    ),
                  ),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.provider.pendientes.length > 0)
                    ListaPendiente(
                      lista: widget.provider.pendientes,
                      orientation: orientation,
                    ),
                  if (widget.provider.lista.length > 0)
                    ListaPDF(
                      lista: widget.provider.lista,
                      orientation: orientation,
                    ),
                ],
              ),
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
