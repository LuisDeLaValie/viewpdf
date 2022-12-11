import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:viewpdf/UI/screen/home/widget/portada_libro.dart';
import 'package:viewpdf/model/libros_model.dart';

class ViewLista extends StatefulWidget {
  const ViewLista({Key? key}) : super(key: key);

  @override
  State<ViewLista> createState() => _ViewListaState();
}

class _ViewListaState extends State<ViewLista> {
  List<LibrosModel> lista = [];
  @override
  void initState() {
    super.initState();
    getInfoApi();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: lista.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (_, key) {
          return PortadaLibro(libro: lista[key]);
        },
      ),
    );
  }

  Future<List<LibrosModel>> getInfoApi() async {
    var request = http.Request(
      'GET',
      Uri.http(
        "localhost",
        "/libros",
      ),
    );
    var response = await request.send().timeout(Duration(milliseconds: 30000));

    var res = jsonDecode(await response.stream.bytesToString()) as List;

    var data = res.map((e) => LibrosModel.fromApi(e));
    setState(() {
      lista = data.toList();
    });
    return data.toList();
  }
}
