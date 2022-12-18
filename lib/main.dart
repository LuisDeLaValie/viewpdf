import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:viewpdf/UI/shared/theme/theme_web.dart';
import 'package:viewpdf/model/autor_model.dart';
import 'package:viewpdf/services/router/handler/crear_handler.dart';
import 'package:viewpdf/services/router/handler/detalles_hendler.dart';
import 'package:viewpdf/services/router/handler/home_handler.dart';

import 'model/colecion_model.dart';
import 'model/libros_model.dart';
// import 'services/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // MyRouter.configureRouter();
  await LibrosDb.openBox();
  await ColecionDb.openBox();
  await AutorDB.openBox();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = GoRouter(
    initialLocation: '/inicio',
    routes: [
      ...HomeHandler.router,
      ...DetallesHendler.router,
      ...CrearHandler.router,
    ],
    redirect: (context, state) {
      var lista = [
        ...HomeHandler.router,
        ...DetallesHendler.router,
        ...CrearHandler.router,
      ].map((e) => e.path).toList();
      if (lista.contains(state.location)) {
        return null;
      } else {
        return "/inicio";
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeWeb.theme,
      title: 'My Libreria',
      routerConfig: _router,
      // initialRoute: homeRoute,
      // navigatorKey: MyRouter.navigatorKey,
      // onGenerateRoute: MyRouter.router.generator,
      builder: (context, child) => child!,
    );
  }
}
