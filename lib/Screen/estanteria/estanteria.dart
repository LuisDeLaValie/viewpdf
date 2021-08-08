import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:viewpdf/Colors/ColorA.dart';
import 'package:viewpdf/Screen/CurpoGeneral.dart';
import 'package:viewpdf/Screen/estanteria/Guardados/EstanteriaGuardados.dart';
import 'package:viewpdf/Screen/estanteria/pendientes/EstanteriaPendientes.dart';
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
    widget.provider.init();
  }

  int page = 0;
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<SelectProvider>(context);

    final pendiente = widget.provider.pendiens;
    final guardados = widget.provider.guardados;

    Widget curpo;
    Widget option;
    Widget optionSelect;
    if (page == 0) {
      curpo = EstanteriaPendientes(lista: pendiente);
      option = OptionsPendientes();
      optionSelect = OptionSelct(lista: pendiente!);
    } else if (page == 1) {
      curpo = EstanteriaGuardados(lista: guardados);
      option = OptionsGuardados();
      optionSelect = OptionSelct(lista: guardados!);
    } else {
      curpo = Configuracion();
      option = Container();
      optionSelect = Container();
    }
    return CurpoGeneral(
      titulo: tiulo,
      actions: [
        if (pro.isSelect) optionSelect,
      ],
      body: curpo,
      floatingActionButton: option,
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
}
