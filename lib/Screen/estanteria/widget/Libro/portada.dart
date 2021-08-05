import 'dart:io';

import 'package:flutter/material.dart';

class Portada extends StatelessWidget {
  final String path;
  const Portada({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.file(
          File(path),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
