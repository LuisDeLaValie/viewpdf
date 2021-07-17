import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/providers/PDFProvider.dart';

class ZoomPage extends StatelessWidget {
  ZoomPage({Key? key}) : super(key: key);

  String _porsenaje = "0%";

  void calcularZoom(double por) {
    por--;
    _porsenaje = (por * 100 / 2).toStringAsFixed(2) + "%";
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<PDFProvider>(context);

    calcularZoom(pro.zoom);

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          booton(true, true, pro),
          Container(
            color: Colors.white,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(8),
            child: Text(
              "$_porsenaje",
              style: TextStyle(color: Colors.black),
            ),
          ),
          booton(false, true, pro),
        ],
      ),
    );
  }

  Widget booton(bool sumres, bool enable, PDFProvider pro) {
    final double size = 30;

    return Container(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[400],
          padding: EdgeInsets.all(0),
        ),
        onPressed: () {
          if (enable) {
            if (sumres)
              pro.zoom += 0.25;
            else
              pro.zoom -= 0.25;
          }
        },
        child: sumres ? Icon(Icons.add) : Icon(Icons.remove),
      ),
    );
  }
}
