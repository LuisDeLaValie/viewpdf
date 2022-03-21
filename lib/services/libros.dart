import 'dart:math';

import 'package:hive/hive.dart';
import 'package:viewpdf/db/EstanteriaHive.dart';
import 'package:viewpdf/db/Libro_hive.dart';
import 'package:viewpdf/model/EstanteriaModel.dart';
import 'package:viewpdf/services/ManejoarPDF.dart';
import 'package:viewpdf/model/PDFModel.dart';

class Libros {
  void dispose() {
    EstanteriaHive.instance.box.close();
    LibroHive.instance.box.close();
  }

  Future<PDFModel> nuevoPDF(String nombre, String path) async {
    final fecha = DateTime.now();
    String key = "${fecha.millisecondsSinceEpoch}-" + _generateRandomString(4);

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
    await LibroHive.instance.box.put(key, pdf);

    return pdf;
  }

  Future<void> guardar(List<String> keys) async {
    var items = LibroHive.instance.box.values
        .where((element) => keys.contains(element.id));

    var updates = <dynamic, PDFModel>{
      for (var e in items) e.key: e..isTemporal = false
    };
    LibroHive.instance.box.putAll(updates);

    var adds = <dynamic, EstanteriaModel>{
      for (var e in items)
        "Esta-${e.key}": EstanteriaModel(
          id: "Esta-${e.id}",
          nombre: e.name,
          isColeection: false,
          libros: HiveList(LibroHive.instance.box, objects: [e]),
        )
    };
    EstanteriaHive.instance.box.putAll(adds);
  }

  Future<void> crearColeccion(String nombre, List<String> keys) async {
    var lib = LibroHive.instance.box.values
        .where((element) => keys.contains(element.key))
        .toList();
    EstanteriaHive.instance.box.deleteAll(keys);

    final fecha = DateTime.now().millisecondsSinceEpoch;
    String key = "Colec-$fecha-" + _generateRandomString(4);
    var estan = EstanteriaModel(
      id: key,
      nombre: nombre,
      isColeection: true,
      libros: HiveList(LibroHive.instance.box, objects: lib),
    );

    EstanteriaHive.instance.box.put(key, estan);
  }

  Future<void> agregarLibros(dynamic key, List<String> keys) async {
    var lib = LibroHive.instance.box.values
        .where((element) => keys.contains(element.key))
        .toList();
    EstanteriaHive.instance.box.deleteAll(keys);

    EstanteriaHive.instance.box.get(key)?.libros.addAll(lib);
  }

  Future<List<PDFModel?>> listarColecion(String key) async {
    final res = (EstanteriaHive.instance.box.get(key)?.libros)?.toList() ?? [];

    return res;
  }

  Future<int> limpiar({List<String>? keys}) async {
    var libros = LibroHive.instance.box.values
        .where((item) => item.isTemporal || (keys?.contains(item.id) ?? false))
        .toList();

    for (var item in libros) {
      var res = await ManejoarPDF().eliminarPDF(item.path);
      if (res) {
        item.delete();
      }
    }

    return libros.length;
  }

  String _generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  void eliminarColeccion(List<String> keys, bool limpiar) async {
    var estan = EstanteriaHive.instance.box.values;

    for (var item in estan) {
      if (keys.contains(item.key)) {
        if (limpiar) {
          var listLibros = item.libros.map((e) => e.id).toList();
          await guardar(listLibros);
        }
        item.delete();
      }
    }
  }
}
