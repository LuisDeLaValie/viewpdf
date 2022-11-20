import 'package:flutter/material.dart';

class ViewLista extends StatelessWidget {
  const ViewLista({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: 30,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (_, key) {
          return Container(
            color: Colors.redAccent,
            margin: EdgeInsets.all(10),
          );
        },
      ),
    );
  }
}
