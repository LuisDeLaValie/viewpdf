import 'package:flutter/material.dart';

import 'package:viewpdf/Colors/ColorA.dart';

class CurpoGeneral extends StatelessWidget {
  final Widget? floatingActionButton;
  final Widget? body;
  final String? titulo;
  final Widget? bottomNavigationBar;
  final List<Widget>? actions;
  const CurpoGeneral({
    Key? key,
    this.floatingActionButton,
    this.body,
    this.titulo,
    this.bottomNavigationBar,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorA.gunmetal,//ColorA.bdazzledBlue,
        title: Text(titulo ?? ""),
        actions: actions,
      ),
      backgroundColor: ColorA.gunmetal,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
