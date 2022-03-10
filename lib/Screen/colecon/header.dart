import 'package:flutter/material.dart';
import 'package:viewpdf/Colors/ColorA.dart';
import 'package:viewpdf/Screen/estanteria/widget/Libro/portada.dart';

class Header extends StatelessWidget {
  final String title;
  final String path;
  const Header({
    Key? key,
    required this.title,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorA.bdazzledBlue,
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 110,
            height: 190,
            child: Portada(path: path),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
