import 'package:flutter/material.dart';
import 'package:viewpdf/UI/shared/theme/theme_web.dart';

import 'services/router/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  MyRouter.configureRouter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeWeb.theme,
      title: 'My Libreria',
      initialRoute: homeRoute,
      navigatorKey: MyRouter.navigatorKey,
      onGenerateRoute: MyRouter.router.generator,
      builder: (context, child) => child!,
    );
  }
}
