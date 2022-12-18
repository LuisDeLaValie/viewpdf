import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/UI/shared/theme/Colors/ColorA.dart';
import 'package:viewpdf/provider/home_provider.dart';

class BuscarHeaderWhitget extends StatefulWidget {
  const BuscarHeaderWhitget({Key? key}) : super(key: key);

  @override
  State<BuscarHeaderWhitget> createState() => _BuscarHeaderWhitgetState();
}

class _BuscarHeaderWhitgetState extends State<BuscarHeaderWhitget> {
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        hintText: "Buscar",
        fillColor: ColorA.lightCyan,
        hintStyle: TextStyle(color: ColorA.bdazzledBlue),
      ),
      onChanged: (value) {
        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 1250), () {
          context.read<HomeProvider>().search = value;
        });
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
