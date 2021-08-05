import 'package:flutter/material.dart';

import 'package:viewpdf/Colors/ColorA.dart';

class CurpoGeneral extends StatelessWidget {
  final Widget? floatingActionButton;
  final Widget? body;
  const CurpoGeneral({Key? key, this.floatingActionButton, this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorA.gunmetal,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
