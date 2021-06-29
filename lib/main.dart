import 'package:flutter/material.dart';
import 'package:viewPDF/DB/ListaData.dart';

import 'DB/db.dart';
import 'Screen/estanteria/estanteria.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();
  await EstanteriaDB.instance.init();

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
      home: EstanteriaScreen(),
    );
  }
}
