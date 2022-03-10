import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Screen/estanteria/estanteria.dart';
import 'db/EstanteriaHive.dart';
import 'db/Libro_hive.dart';
import 'model/EstanteriaModel.dart';
import 'model/PDFModel.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(PDFModelAdapter());
  Hive.registerAdapter(EstanteriaModelAdapter());

  await EstanteriaHive.instance.init();
  await LibroHive.instance.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
@override
void initState() {
  super.initState();
 
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: EstanteriaScreen(),
    );
  }
}
