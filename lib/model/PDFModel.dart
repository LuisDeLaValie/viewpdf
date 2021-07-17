import 'package:sembast/timestamp.dart';

class PDFModel {
  String? id;
  int? page;
  String? path;
  String? portada;
  String? name;
  Timestamp? actualizado;
  bool? isTemporal;
  double? zoom;
  bool isSelect = false;

  PDFModel(
      {this.id,
      required this.name,
      required this.path,
      required this.portada,
      required this.actualizado,
      this.page = 0,
      this.isTemporal = true,
      this.zoom = 1});

  static PDFModel fromJson(Map<String, dynamic> map) {
    return PDFModel(
      id: map['id'],
      page: map['page'],
      path: map['path'],
      portada: map['portada'],
      name: map['name'],
      actualizado: map['actualizado'],
      isTemporal: map['isTemporal'],
      zoom: map['zoom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'page': this.page,
      'path': this.path,
      'portada': this.portada,
      'name': this.name,
      'actualizado': this.actualizado,
      'isTemporal': this.isTemporal,
      'zoom': this.zoom
    };
  }

  PDFModel copyWith({
    String? id,
    int? page,
    String? path,
    String? name,
    Timestamp? actualizado,
    bool? isTemporal,
    double? zoom,
  }) {
    return PDFModel(
      id: id ?? this.id,
      page: page ?? this.page,
      path: path ?? this.path,
      portada: portada ?? this.portada,
      name: name ?? this.name,
      actualizado: actualizado ?? this.actualizado,
      isTemporal: isTemporal ?? this.isTemporal,
      zoom: zoom ?? this.zoom,
    );
  }
}
