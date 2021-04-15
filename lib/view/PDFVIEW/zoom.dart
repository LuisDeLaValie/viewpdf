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
        children: [
          booton(true, "+", (_zoomI < _zooms.length)),
          Container(
            margin: EdgeInsets.all(5),
            child: Text("$_porsenaje"),
          ),
          booton(false, "-", (_zoomI > 0)),
        ],
      ),
    );
  }

  Widget booton(bool sumres, String signo, bool enable) {
    return InkWell(
      onTap: () {
        if (enable) {
          chanZoom(sumres);
          widget.zoomChange(sumres);
        }
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[350],
        ),
        child: Text(
          signo,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
