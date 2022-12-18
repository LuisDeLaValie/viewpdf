import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/UI/shared/theme/Colors/ColorA.dart';
import 'package:viewpdf/provider/home_provider.dart';
import 'buscar_header_whitget.dart';
import 'filtros_header_whidget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              FiltrosHeaderWhidget(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                constraints: BoxConstraints(maxWidth: 250, minWidth: 50),
                child: BuscarHeaderWhitget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
