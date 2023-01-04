import 'package:go_router/go_router.dart';
import 'package:viewpdf/UI/screen/detalles/detalles_screen_web.dart';

class DetallesHendler {
  static List<GoRoute> router = [
    GoRoute(
      name: "detallesLibro",
      path: '/detalles/libro/:id',
      builder: (context, state) => DetallesScreenWeb(
        id: state.params['id'] ?? "",
      ),
    )
  ];
}
