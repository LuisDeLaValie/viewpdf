import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/Colors/ColorA.dart';
import 'package:viewpdf/providers/PDFProvider.dart';

class LaPage extends StatefulWidget {
  final Function(int) onPageChanged;
  LaPage({Key? key, required this.onPageChanged}) : super(key: key);

  @override
  _LaPageState createState() => _LaPageState();
}

class _LaPageState extends State<LaPage> {
  @override
  void initState() {
    super.initState();
  }

  bool enable = false;
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<PDFProvider>(context);
    final allPage = pro.allPage;
    final actualPage = pro.page;

    return enable ? cambiar(actualPage) : nornal(actualPage, allPage);
  }

  Widget nornal(int actual, int total) {
    return InkWell(
      onTap: () {
        setState(() {
          enable = true;
        });
      },
      child: Container(
        width: 60,
        height: 30,
        child: Center(
          child: Text(
            "$actual/$total",
            style: TextStyle(
              fontSize: 14,
              color: ColorA.lightCyan,
            ),
          ),
        ),
      ),
    );
  }

  final pageController = new TextEditingController();
  Widget cambiar(int actual) {
    pageController.text = "$actual";
    return TextField(
      autofocus: true,
      style: TextStyle(color: ColorA.lightCyan),
      controller: pageController,
      keyboardType: TextInputType.number,
      onSubmitted: (s) {
        widget.onPageChanged(int.parse(s));
        setState(() {
          enable = false;
        });
      },
    );
  }
}
