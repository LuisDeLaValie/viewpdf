import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/Colors/ColorA.dart';

import 'package:viewpdf/providers/PDFProvider.dart';

class ZoomPage extends StatefulWidget {
  final void Function(double zoom) onZoomChanged;
  ZoomPage({Key? key, required this.onZoomChanged}) : super(key: key);

  @override
  _ZoomPageState createState() => _ZoomPageState();
}

class _ZoomPageState extends State<ZoomPage> {
  String _porsenaje = "0%";

  void calcularZoom(double por) {
    por--;
    _porsenaje = (por * 100 / 2).toStringAsFixed(2) + "%";
  }

  bool enable = false;

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<PDFProvider>(context);

    calcularZoom(pro.zoom);

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          booton(true, true, pro),
          nornal(_porsenaje),
          booton(false, true, pro),
        ],
      ),
    );
  }

  Widget nornal(String prsenaje) {
    return InkWell(
      onTap: () {
        setState(() {
          enable = true;
        });
      },
      child: Container(
        width: 60,
        height: 30,
        // color: ColorA.lightCyan,
        child: Center(
          child: Text(
            "$prsenaje",
            style: TextStyle(
              fontSize: 14,
              color: ColorA.lightCyan,
            ),
          ),
        ),
      ),
    );
  }

  Widget booton(bool sumres, bool enable, PDFProvider pro) {

    return IconButton(
      icon: sumres ? Icon(Icons.arrow_left) : Icon(Icons.arrow_right),
      onPressed: () {
        if (enable) {
          double zoo;
          if (sumres)
            zoo = pro.zoom + 0.25;
          else
            zoo = pro.zoom - 0.25;

          widget.onZoomChanged(zoo);
        }
      },
    );
  }
}
