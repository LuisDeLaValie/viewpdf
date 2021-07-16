import 'package:flutter/material.dart';
import 'package:viewpdf/DB/ListaData.dart';

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
      theme: ThemeData(
        // Define the default brightness and colors.
        // brightness: Brightness.dark,
        primaryColor: Colors.pink,
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'hack',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: EstanteriaScreen(),
    );
  }
}
