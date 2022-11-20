import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'handler/home_handler.dart';

// login
const String homeRoute = 'home';
const String crearRoute = 'crear';

class MyRouter {
  static final FluroRouter router = FluroRouter();
  static final navigatorKey = GlobalKey<NavigatorState>();

  static void configureRouter() {
    // home
    router.define(homeRoute, handler: HomeHandler.home);
    router.define(crearRoute, handler: HomeHandler.crear);

    router.notFoundHandler = _notfount;
  }

  static final Handler _notfount = Handler(handlerFunc: (context, params) {
    return Scaffold(
      body: Text("NO se encontro el Recurso"),
    );
  });

  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> limpiar(String routeName,
      {Object? arguments, String? predicate}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName(predicate ?? ""),
      arguments: arguments,
    );
  }

  static Future<dynamic> navigateToReplacement(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }
}
