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
    final estan = await EstatnteriaStore.instance.listar();

    List<String> keys = estan.map((e) => e!.libros[0].key).toList();
    final res = await LibreriaStore.instance.listar(
      finder: Finder(filter: Filter.inList("id", keys)),
    );

    List<EstanteriaModel?> keyscolection =
        estan.where((element) => element!.isColeection).toList();
    keys = keyscolection.map((e) => e!.libros[0].key).toList();
    final res1 = await LibreriaStore.instance.listar(
      finder: Finder(filter: Filter.inList("id", keys)),
    );

    final resaux = res1.map((e) {
      if (keyscolection.length > 0) {
        EstanteriaModel? aux = keyscolection.lastWhere(
          (element) {
            var keys = element!.libros.map((e) => e.key).toList();
            var res = keys.contains(e.id);
            return res;
          },
          orElse: () => EstanteriaModel(
              isColeection: false, key: '', libros: [], nombre: ''),
        );
        if (aux?.libros.isNotEmpty ?? false) {
          e.id = aux?.key ?? '';
          e.name = aux?.nombre ?? '';
        }
      }
      return e;
    }).toList();

    res.addAll(resaux);
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
    final filter = Filter.or(
      [
        Filter.equals('isTemporal', true),
        Filter.inList('id', keys ?? []),
      ],
    );

    final poreliminar = await LibreriaStore.instance.listar(
      finder: Finder(filter: filter),
    );

    for (var item in poreliminar) {
      await ManejoarPDF().eliminarPDF(item.path);
    }

    final eliminados = await LibreriaStore.instance.eliminar(
      finder: Finder(filter: filter),
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
    String key = "${fecha.millisecond}-" + _generateRandomString(4);

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

  static Future<void> crearColeccion(String nombre, List<String> keys) async {
    final libros = await LibreriaStore.instance.listar(
      finder: Finder(
        filter: Filter.inList('id', keys),
      ),
    );

    final loslibros = libros
        .map((val) => LibroEstanteria(key: val.id, nombre: val.name))
        .toList();

    final fecha = DateTime.now().millisecond;
    String key = "$fecha-" + _generateRandomString(4);

    final estanteria = EstanteriaModel(
      key: "Esta-$key",
      nombre: nombre,
      libros: loslibros,
      isColeection: true,
    );

    await EstatnteriaStore.instance.crear(estanteria);

    await EstatnteriaStore.instance.eliminar(
      filter: Finder(
        filter: Filter.equals('key', "Esta-$key"),
      ),
    );
  }

  static void eliminarColeccion(String key) async {
    final colecion = await EstatnteriaStore.instance.ver(
      finder: Finder(
        filter: Filter.equals('key', key),
      ),
    );
    final libros = colecion!.libros.map((e) => e.key).toList();
    await guardar(libros);
    await EstatnteriaStore.instance.eliminar(
      filter: Finder(
        filter: Filter.equals('key', key),
      ),
    );
  }
}
