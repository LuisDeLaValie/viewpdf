import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class BibliotecaApi {
  late String _hosth;
  BibliotecaApi() {
    // flutter run lib/main.dart
    //--dart-define=SUPABASE_URL=url
    //--dart-define=SUPABASE_ANNON_KEY=key

    const String hosth = String.fromEnvironment(
      "LIBRERIS_API",
      defaultValue: "localhost",
    );
    _hosth = hosth;
  }

  Future<dynamic> get(
      String path, Map<String, dynamic>? queryParameters) async {
    var request = http.Request('GET', Uri.http(_hosth, path, queryParameters));
    var response = await request.send().timeout(Duration(milliseconds: 30000));

    if (response.statusCode == 200) {
      return jsonDecode(await response.stream.bytesToString());
    } else {
      throw response.reasonPhrase ?? "Error desconocido";
    }
  }

  Future<dynamic> crear(
    String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  ) async {
    try {
      var request = http.Request(
        'POST',
        Uri.http(_hosth, path, queryParameters),
      );
      var response =
          await request.send().timeout(Duration(milliseconds: 30000));

      if (response.statusCode == 201) {
        return jsonDecode(await response.stream.bytesToString());
      } else {
        throw response.reasonPhrase ?? "Error desconocido";
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> actualizar(
    String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  ) async {
    try {
      var request = http.Request(
        'PUT',
        Uri.http(_hosth, path, queryParameters),
      );
      var response =
          await request.send().timeout(Duration(milliseconds: 30000));

      if (response.statusCode == 204) {
        return jsonDecode(await response.stream.bytesToString());
      } else {
        throw response.reasonPhrase ?? "Error desconocido";
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> eliminar(
      String path, Map<String, dynamic>? queryParameters) async {
    try {
      var request = http.Request(
        'DELETE',
        Uri.http(_hosth, path, queryParameters),
      );
      var response =
          await request.send().timeout(Duration(milliseconds: 30000));

      if (response.statusCode == 204) {
        return jsonDecode(await response.stream.bytesToString());
      } else {
        throw response.reasonPhrase ?? "Error desconocido";
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
