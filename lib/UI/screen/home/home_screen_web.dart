import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/UI/shared/layout/layout_home.dart';
import 'package:viewpdf/UI/shared/theme/Colors/ColorA.dart';
import 'package:viewpdf/provider/crear_libro_provider.dart';
import 'package:viewpdf/services/router/router.dart';

import 'view/view_lista.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({Key? key}) : super(key: key);

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutHome(
      titulo: "Inico",
      body: ViewLista(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorA.burntSienna,
        onPressed: () {
          MyRouter.navigateTo(crearRoute);
        },
        child: Icon(
          Icons.add,
          color: ColorA.lightCyan,
        ),
      ),
    );
  }
}
