import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/UI/shared/theme/Colors/ColorA.dart';
import 'package:viewpdf/provider/home_provider.dart';

class FiltrosHeaderWhidget extends StatelessWidget {
  FiltrosHeaderWhidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var filtro = context
        .select<HomeProvider, FiltroEstanteria>((HomeProvider p) => p.filto);

    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: ColorA.lightCyan,
        borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownButton<FiltroEstanteria>(
        value: filtro,
        icon: const Icon(
          Icons.filter_alt,
          color: ColorA.burntSienna,
        ),
        elevation: 0,
        style: const TextStyle(color: ColorA.bdazzledBlue),
        dropdownColor: ColorA.lightCyan,
        underline: Container(),
        items: [
          DropdownMenuItem<FiltroEstanteria>(
            value: FiltroEstanteria.todos,
            child: Text("Todos"),
          ),
          DropdownMenuItem<FiltroEstanteria>(
            value: FiltroEstanteria.libors,
            child: Text("Libros"),
          ),
          DropdownMenuItem<FiltroEstanteria>(
            value: FiltroEstanteria.colenciones,
            child: Text("Coleccion"),
          ),
        ],
        onChanged: (FiltroEstanteria? value) {
          var pr = context.read<HomeProvider>();
          pr.filto = value!;
          pr.getEstanteria();
        },
      ),
    );
  }
}
