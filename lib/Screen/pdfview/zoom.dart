import 'package:flutter/material.dart';

class ZoomPage extends StatefulWidget {
  final double initZoom;
  final Function(bool sumres) zoomChange;
  ZoomPage({Key? key, this.initZoom = 1, required this.zoomChange})
      : super(key: key);

  @override
  _ZoomPageState createState() => _ZoomPageState();
}

class _ZoomPageState extends State<ZoomPage> {
  int _zoomI = 0;
  String _porsenaje = "0%";
  @override
  void initState() {
    super.initState();
  }

  void calcularZoom(double por) {
    _zoomI = 0;
    por--;
    setState(() {
      _porsenaje = (por * 100 / 2).toString() + "%";
    });
  }

  chanZoom(bool sumres) {
    if (sumres)
      _zoomI++;
    else
      _zoomI--;
    setState(() {
      _porsenaje = (12.5 + (12.5 * _zoomI)).toString() + "%";
    });
  }

  @override
  Widget build(BuildContext context) {
    calcularZoom(widget.initZoom);
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          booton(true, true),
          Container(
            color: Colors.white,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(8),
            child: Text(
              "$_porsenaje",
              style: TextStyle(color: Colors.black),
            ),
          ),
          booton(false, true),
        ],
      ),
    );
  }

  Widget booton(bool sumres, bool enable) {
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
            chanZoom(sumres);
            widget.zoomChange(sumres);
          }
        },
        child: sumres ? Icon(Icons.add) : Icon(Icons.remove),
      ),
    );
  }
}
