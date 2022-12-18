import 'package:go_router/go_router.dart';
import 'package:viewpdf/UI/screen/detalles/detalles_screen_web.dart';

class DetallesHendler {
  static List<GoRoute> router = [
    GoRoute(
      path: '/detalles',
      builder: (context, state) => DetallesScreenWeb(),
    )
  ];
}
