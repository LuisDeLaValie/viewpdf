import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:viewpdf/Screen/CurpoGeneral.dart';
import 'package:viewpdf/Screen/estanteria/Guardados/EstanteriaGuardados.dart';
import 'package:viewpdf/Screen/estanteria/pendientes/EstanteriaPendientes.dart';
import 'package:viewpdf/Screen/estanteria/widget/Anuncios.dart';
import 'package:viewpdf/Screen/estanteria/widget/Menu/MainMenu.dart';
import 'package:viewpdf/Screen/estanteria/widget/Menu/Options.dart';
import 'package:viewpdf/Screen/estanteria/widget/Menu/optionSelct.dart';
import 'package:viewpdf/providers/EstanteriaProvider.dart';

import 'package:provider/provider.dart';
import 'package:viewpdf/providers/SelectProvider.dart';

import 'configuracion/Configuracion.dart';

class EstanteriaScreen extends StatelessWidget {
  const EstanteriaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EstanteriaProvider>(
            create: (_) => EstanteriaProvider()),
        ChangeNotifierProvider<SelectProvider>(create: (_) => SelectProvider()),
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

class __EstanteriaScreenState extends State<_EstanteriaScreen>
    with SingleTickerProviderStateMixin {
  Finder? ordenar;
  @override
  void initState() {
    super.initState();
    Interstitial.instance.inicio();
    widget.provider.init();
  }

  int page = 0;
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<SelectProvider>(context);
    final data = viewvista();
    return CurpoGeneral(
      titulo: tiulo,
      actions: [
        if (pro.isSelect) data[2],
      ],
      body: data[0],
      floatingActionButton: data[1],
      bottomNavigationBar: MainMenu(
        onTap: (int) {
          titulos(int);
          setState(() {
            page = int;
          });
        },
      ),
    );
  }

  String tiulo = "Titulo";
  void titulos(int key) {
    if (key == 0) {
      setState(() {
        tiulo = "Temporal";
      });
    } else if (key == 1) {
      setState(() {
        tiulo = "Guardados";
      });
    } else if (key == 2) {
      setState(() {
        tiulo = "Configuracions";
      });
    }
  }

  viewvista() {
    Widget curpo;
    Widget option;
    Widget optionSelect;

    if (page == 0) {
      curpo = EstanteriaPendientes();
      option = OptionsPendientes();
      optionSelect = OptionSelct(
        vista: true,
      );
    } else if (page == 1) {
      curpo = EstanteriaGuardados();
      option = OptionsGuardados();
      optionSelect = OptionSelct(
        vista: false,
      );
    } else {
      curpo = Configuracion();
      option = Container();
      optionSelect = Container();
    }

    return [curpo, option, optionSelect];
  }
}
