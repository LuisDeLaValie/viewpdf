import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:viewpdf/Colors/ColorA.dart';
import 'package:viewpdf/Screen/estanteria/widget/Libro/portada.dart';
import 'package:viewpdf/providers/Editar_colecion.dart';

class Header extends StatefulWidget {
  final String title;
  final String path;
  Header({
    Key? key,
    required this.title,
    required this.path,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<EditarColecionProvider>(context);
    pro.nombre = widget.title;

    Widget textnombre = Flexible(
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
    Widget editnombre = Expanded(
      child: Container(
        color: Colors.white,
        child: TextFormField(
          initialValue: widget.title,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onChanged: (value) {
            pro.nombre = value;
          },
        ),
      ),
    );

    return Container(
      color: ColorA.bdazzledBlue,
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 110,
            height: 190,
            child: Portada(path: widget.path),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              pro.onEdit ? editnombre : textnombre,
              FloatingActionButton(
                onPressed: () {
                  final Uri uri = Uri.file(widget.path);
                  print(uri.toString());
                  launch("file:///data/user/0/com.TDTxLe.viewPDF/app_flutter/1647890449041-shha");
                },
                child:
                    Icon(Icons.edit, color: Color.fromARGB(255, 161, 47, 47)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
