import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Screen/estanteria/estanteria.dart';
import 'db/models/hive_libreria.dart';
import 'db/models/hive_libros.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  HiveLibros.open();
  HiveLibreria.open();

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
