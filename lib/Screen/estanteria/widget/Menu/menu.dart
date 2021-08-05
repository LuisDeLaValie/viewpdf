import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewpdf/Screen/pdfview/MyPDFScreen.dart';
import 'package:viewpdf/providers/EstanteriaProvider.dart';
import 'package:viewpdf/providers/SelectProvider.dart';

class OptionsPendientes extends StatelessWidget {
  const OptionsPendientes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EstanteriaProvider>(context);
    final proSelect = Provider.of<SelectProvider>(context);
    return BounceInDown(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
         if(proSelect.isSelect) Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    pro.limpiarlista();
                  },
                  child: Icon(Icons.book_sharp),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    pro.limpiarlista();
                  },
                  child: Icon(Icons.clear),
                ),
              ],
            ),
          ),

          //opciones generales
          Container(
            child: BounceInDown(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (pro.pendiens!.length > 1)
                    BounceInRight(
                      child: FloatingActionButton(
                        onPressed: () async {
                          pro.limpiarlista();
                        },
                        child: Icon(Icons.clear_all_outlined),
                      ),
                    ),
                  FloatingActionButton(
                    onPressed: () async {
                      final res = await pro.getPDF();
                      await pro.listarpendiens();
                      if (res['actualizar']) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyPDFScreen(pdf: res['pdf'])),
                        );
                      }
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
