import 'package:flutter/material.dart';

import 'package:viewpdf/Colors/ColorA.dart';

class NoLibro extends StatelessWidget {
  final Function()? onRefres;
  const NoLibro({Key? key, this.onRefres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_outlined,
            size: 150,
            color: ColorA.lightCyan,
          ),
          Text(
            "No hay resultado.",
            style: TextStyle(color: ColorA.lightCyan),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: ColorA.bdazzledBlue),
            onPressed: () {
              onRefres!();
            },
            child: const Text('Refrescar'),
          ),
        ],
      ),
    );
  }
}
