import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:viewpdf/Colors/ColorA.dart';
import 'package:viewpdf/providers/EstanteriaProvider.dart';
import 'package:viewpdf/providers/SelectProvider.dart';

class OptionSelct extends StatelessWidget {
  final bool vista;
  const OptionSelct({Key? key, required this.vista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<SelectProvider>(context);
    final pro2 = Provider.of<EstanteriaProvider>(context);

    List<String> lista = [];
    if (vista)
      lista = pro2.pendienteKes;
    else
      lista = pro2.guardadosKesy;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          child: IconButton(
            icon: Icon(
              Icons.select_all,
              color: ColorA.burntSienna,
            ),
            onPressed: () {
              pro.multiselcet(lista);
            },
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(
              Icons.cancel,
              color: ColorA.burntSienna,
            ),
            onPressed: () {
              pro.cancel();
            },
          ),
        ),
      ],
    );
  }
}
