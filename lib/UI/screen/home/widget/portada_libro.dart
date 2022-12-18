import 'package:flutter/material.dart';
import 'package:tdtxle_inputs_flutter/inputs/img_perfil.dart';

class PortadaLibro extends StatelessWidget {
  final String titulo;
  final String portada;
  const PortadaLibro({
    Key? key,
    required this.titulo,
    required this.portada,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        elevation: 5,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: ImagenPerfil(imgPath: portada),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Text(titulo),
            ),
          ],
        ),
      ),
    );
  }
}
