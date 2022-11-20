import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/UI/screen/crear/crear_screen_web.dart';
import 'package:viewpdf/UI/screen/home/home_screen_web.dart';
import 'package:viewpdf/provider/crear_libro_provider.dart';

class HomeHandler {
  static Handler home = Handler(handlerFunc: (context, params) {
    return ChangeNotifierProvider<CrearLibroProvider>(
      create: (context) => CrearLibroProvider(),
      child: const HomeScreenWeb(),
    );
  });

  static Handler crear = Handler(handlerFunc: (context, params) {
    return const CrearScreenWeb();
  });
}
