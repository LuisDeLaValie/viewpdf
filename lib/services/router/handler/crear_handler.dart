import 'package:go_router/go_router.dart';
import 'package:viewpdf/UI/screen/crear/crear_screen_web.dart';

class CrearHandler {
  static List<GoRoute> router = [
    GoRoute(
      path: '/crear',
      builder: (context, state) => CrearScreenWeb(),
    )
  ];
}
