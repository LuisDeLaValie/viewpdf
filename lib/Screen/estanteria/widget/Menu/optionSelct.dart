import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:viewpdf/Colors/ColorA.dart';
import 'package:viewpdf/model/PDFModel.dart';
import 'package:viewpdf/providers/SelectProvider.dart';

class OptionSelct extends StatelessWidget {
  final List<PDFModel> lista;
  const OptionSelct({Key? key, required this.lista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<SelectProvider>(context);
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
              int ky = 0;
              final res = lista.map<ItemSelect>((e) {
                final a = ItemSelect(index: ky, key: e.id);
                ky++;
                return a;
              }).toList();
              pro.multiselcet(res);
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
