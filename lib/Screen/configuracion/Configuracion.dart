import 'package:flutter/material.dart';
import 'package:viewpdf/Screen/configuracion/directoriso.dart';
import 'package:permission_handler/permission_handler.dart';


class Configuracion extends StatelessWidget {
  const Configuracion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            tileColor: Colors.white,
            title: Text("Directorio"),
            onTap: () async {
              var status = await Permission.storage.status;
              if (!status.isGranted) {
                await Permission.storage.request();
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Directoriso()),
              );
            },
          )
        ],
      ),
    );
  }
}
