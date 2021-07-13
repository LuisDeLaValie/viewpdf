import 'package:flutter/material.dart';

class LaPage extends StatelessWidget {
  final int? allPage;
  final Function(int)? page;
  final TextEditingController? pageController;
  const LaPage({Key? key, this.allPage, this.page, this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  page!(int.parse(s));
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
