import 'dart:convert';

import 'package:sembast/timestamp.dart';

class PDFModel {
  String id = "";
  int page = 0;
  String path = "";
  String name;
  DateTime actualizado;
  bool isTemporal = true;
  double zoom = 1;

  PDFModel({
    this.id = "",
    this.page = 0,
    this.path = "",
    required this.name,
    required this.actualizado,
    this.isTemporal = true,
    this.zoom = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'page': page,
      'path': path,
      'name': name,
      'actualizado': Timestamp.fromDateTime(actualizado),
      'isTemporal': isTemporal,
      'zoom': zoom,
    };
  }

  factory PDFModel.fromMap(Map<String, dynamic> map) {
    return PDFModel(
      id: map['id'] ?? '',
      page: map['page']?.toInt() ?? 0,
      path: map['path'] ?? '',
      name: map['name'] ?? '',
      actualizado: (map['actualizado'] as Timestamp).toDateTime(),
      isTemporal: map['isTemporal'] ?? false,
      zoom: map['zoom']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PDFModel.fromJson(String source) =>
      PDFModel.fromMap(json.decode(source));
}
