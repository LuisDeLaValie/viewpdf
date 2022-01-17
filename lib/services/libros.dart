import 'dart:math';

import 'package:sembast/sembast.dart';
import 'package:viewpdf/DB/estatnteria_Store.dart';
import 'package:viewpdf/DB/libreria_Store.dart';
import 'package:viewpdf/services/ManejoarPDF.dart';
import 'package:viewpdf/model/EstanteriaModel.dart';
import 'package:viewpdf/model/PDFModel.dart';

class Libros {
  static Future<List<PDFModel?>> listarLibros(bool temporales) {
    if (temporales) {
      return _listarTemporales();
    } else {
      return _listarlirbros();
    }
  }

  static Future<List<PDFModel?>> _listarTemporales() async {
    final res = await LibreriaStore.instance.listar(
      finder: Finder(
        filter: Filter.equals("isTemporal", true),
      ),
    );
    return res;
  }

  static Future<List<PDFModel?>> _listarlirbros() async {
    print("Listado de libros temporales");
    final estan = await EstatnteriaStore.instance.listar();
    List<String> keys = [];
    for (var item in estan) {
      keys.add(item!.libros[0].key);
    }

    final res = await LibreriaStore.instance.listar(
      finder: Finder(
        filter: Filter.inList("id", keys),
      ),
    );
    return res;
  }

  static Future<List<PDFModel?>> listarColecion(List<String> keys) async {
    final res = await LibreriaStore.instance.listar(
      finder: Finder(
        filter: Filter.inList("id", keys),
      ),
    );
    return res;
  }

  static Future<int> limpiar({List<String>? keys}) async {
    final eliminados = await LibreriaStore.instance.eliminar(
      finder: Finder(
        filter: Filter.or(
          [
            Filter.equals('isTemporal', true),
            Filter.inList('id', keys ?? []),
          ],
        ),
      ),
    );

    return eliminados;
  }

  static Future<void> guardar(List<String> keys) async {
    await LibreriaStore.instance.actualizar(
      {'isTemporal': false},
      filter: Finder(
        filter: Filter.inList('id', keys),
      ),
    );

    final lis = await LibreriaStore.instance.listar(
      finder: Finder(
        filter: Filter.inList('id', keys),
      ),
    );

    final lalista = lis
        .map(
          (val) => EstanteriaModel(
            key: "Esta-${val.id}",
            nombre: val.name,
            libros: [LibroEstanteria(key: val.id, nombre: val.name)],
            isColeection: false,
          ),
        )
        .toList();

    await EstatnteriaStore.instance.agregar(lalista);
  }

  static String _generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  static Future<PDFModel> nuevoPDF(String nombre, String path) async {
    final fecha = DateTime.now();
    String key = "$fecha-" + _generateRandomString(4);

    final ruta = await ManejoarPDF().moverPdf(path, key);

    final pdf = PDFModel(
      id: key,
      page: 0,
      path: ruta,
      name: nombre,
      actualizado: fecha,
      isTemporal: true,
      zoom: 1,
    );

    await LibreriaStore.instance.add(pdf);

    return pdf;
  }
}
