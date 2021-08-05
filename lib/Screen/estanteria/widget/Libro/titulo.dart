import 'package:flutter/material.dart';
import 'package:viewpdf/Colors/ColorA.dart';

class Titulo extends StatelessWidget {
  final String titulo;
  const Titulo({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        titulo,
        maxLines: 2,
        style: TextStyle(color: ColorA.lightCyan),
      ),
    );
  }
}
