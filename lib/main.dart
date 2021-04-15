import 'package:flutter/material.dart';
import 'package:viewPDF/data/ListaData.dart';

import 'data/db.dart';
import 'view/estanteria.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();

  EstanteriaDB.instance.eliminarTemporal();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Stanteria(),
    );
  }
}
