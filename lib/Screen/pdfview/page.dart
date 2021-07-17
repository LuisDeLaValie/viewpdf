import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/providers/PDFProvider.dart';

class LaPage extends StatelessWidget {
  final Function(int)? page;
  LaPage({Key? key, this.page}) : super(key: key);

  TextEditingController pageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<PDFProvider>(context);
    pageController.text = pro.page.toString();
    final allPage = pro.allPage;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
      ),
      child: Center(
        child: Row(
          children: [
            Container(
              color: Colors.white,
              width: 50,
              height: 30,
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: pageController,
                keyboardType: TextInputType.number,
                onSubmitted: (s) {
                  pro.actualizar(page: int.parse(s));
                },
              ),
            ),
            Text("/$allPage")
          ],
        ),
      ),
    );
  }
}
