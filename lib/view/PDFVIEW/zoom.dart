import 'package:flutter/material.dart';

class ZoomPage extends StatefulWidget {
  final double initZoom;
  final Function(bool sumres) zoomChange;
  ZoomPage({Key key, this.initZoom = 1, @required this.zoomChange})
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
    calcularZoom(widget.initZoom);
  }

  List<double> _zooms = [1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3];

  void calcularZoom(double por) {
    _zoomI = 0;
    _zooms.forEach((element) {
      if (element >= por) return;
      _zoomI++;
    });
    setState(() {
      _porsenaje = (12.5 + (12.5 * _zoomI)).toString() + "%";
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
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          booton(true, (_zoomI < _zooms.length)),
          Container(
            color: Colors.white,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(8),
            child: Text(
              "$_porsenaje",
              style: TextStyle(color: Colors.black),
            ),
          ),
          booton(false, (_zoomI > 0)),
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
