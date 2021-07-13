import 'package:flutter/material.dart';

class Etiqueta extends StatelessWidget {
  final String? texto;
  final Color? color;
  const Etiqueta({Key? key, this.texto, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: (this.color != null) ? this.color : Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Text(
        this.texto!,
        style: TextStyle(fontSize: 8, color: Colors.white),
      ),
    );
  }
}
