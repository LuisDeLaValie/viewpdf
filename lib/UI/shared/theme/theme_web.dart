import 'package:flutter/material.dart';

import 'Colors/ColorA.dart';

class ThemeWeb {
  static ThemeData get theme => ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: ColorA.bdazzledBlue,
          foregroundColor: ColorA.lightCyan,
        ),
      );
}
