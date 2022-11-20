import 'package:flutter/material.dart';

class LayoutHome extends StatelessWidget {
  final Widget body;
  final String? titulo;
  final Widget? floatingActionButton;
  const LayoutHome({
    Key? key,
    required this.body,
    this.titulo,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (titulo != null) ? Text(titulo!) : null,
        centerTitle: false,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
