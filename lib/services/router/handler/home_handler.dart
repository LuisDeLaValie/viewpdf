import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/UI/screen/crear/crear_screen_web.dart';
import 'package:viewpdf/UI/screen/detalles/detalles_screen_web.dart';
import 'package:viewpdf/UI/screen/home/home_screen_web.dart';
import 'package:viewpdf/provider/home_provider.dart';

class HomeHandler {
  static List<GoRoute> router = [
    GoRoute(
      path: '/inicio',
      builder: (context, state) {
        return ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
          child: const HomeScreenWeb(),
        );
      },
    )
  ];
}
