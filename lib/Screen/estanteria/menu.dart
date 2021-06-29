import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewPDF/providers/EstanteriaProvider.dart';

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EstanteriaProvider>(context);
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 1) {
          pro.limpiarlista();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                child: Icon(Icons.clear_all_outlined, color: Colors.grey),
              ),
              Text('Limpiar.')
            ],
          ),
        ),
      ],
    );
  }
}
