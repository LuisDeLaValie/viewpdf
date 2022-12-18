import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/UI/shared/layout/layout_home.dart';
import 'package:viewpdf/UI/shared/theme/Colors/ColorA.dart';
import 'package:viewpdf/provider/home_provider.dart';
import 'package:viewpdf/services/router/router.dart';

import 'view/view_lista.dart';
import 'widget/encabezado/header_widget.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({Key? key}) : super(key: key);

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().getEstanteria();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutHome(
      titulo: "Inico",
      body: Column(
        children: [
          HeaderWidget(),
          Expanded(child: ViewLista()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorA.burntSienna,
        onPressed: () {
          context.go("/crear");
          // MyRouter.navigateTo(crearRoute);
        },
        child: Icon(
          Icons.add,
          color: ColorA.lightCyan,
        ),
      ),
    );
  }
}
