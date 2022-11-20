import 'package:fluro/fluro.dart';
import 'package:viewpdf/UI/screen/crear/crear_screen_web.dart';
import 'package:viewpdf/UI/screen/home/home_screen_web.dart';

class HomeHandler {
  static Handler home = Handler(handlerFunc: (context, params) {
    return const HomeScreenWeb();
  });
  static Handler crear = Handler(handlerFunc: (context, params) {
    return const CrearScreenWeb();
  });
}
