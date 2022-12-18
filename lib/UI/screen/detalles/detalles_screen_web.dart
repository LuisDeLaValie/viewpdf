import 'package:flutter/material.dart';
import 'package:viewpdf/UI/shared/layout/layout_home.dart';

class DetallesScreenWeb extends StatelessWidget {
  const DetallesScreenWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutHome(
      titulo: "Agregar Libro",
      body: Center(
        child: Text("Detalles"),
      ),
    );
  }
}
