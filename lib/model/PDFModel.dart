import 'package:sembast/timestamp.dart';

class PDFModel {
  final String id;
  final int page;
  final String path;
  // final String portada;
  final String name;
  final DateTime? actualizado;
  final bool isTemporal;
  final double zoom;
  // final bool isSelect;

  PDFModel({
    this.id = "",
    this.page = 0,
    this.path = "",
    // this.portada = "",
    this.name = "",
    this.actualizado,
    this.isTemporal = true,
    this.zoom = 1,
    // this.isSelect = false,
  });

  static PDFModel fromJson(Map<String, dynamic> map) {
    return PDFModel(
      id: map['id'],
      page: map['page'],
      path: map['path'],
      // portada: map['portada'],
      name: map['name'],
      actualizado: (map['actualizado'] as Timestamp).toDateTime(),
      isTemporal: map['isTemporal'],
      zoom: map['zoom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'page': this.page,
      'path': this.path,
      // 'portada': this.portada,
      'name': this.name,
      'actualizado': Timestamp.fromDateTime(this.actualizado!),
      'isTemporal': this.isTemporal,
      'zoom': this.zoom
    };
  }

  PDFModel copyWith({
    String? id,
    int? page,
    String? path,
    // String? portada,
    String? name,
    DateTime? actualizado,
    bool? isTemporal,
    double? zoom,
    // bool? isSelect,
  }) {
    return PDFModel(
      id: id ?? this.id,
      page: page ?? this.page,
      path: path ?? this.path,
      // portada: portada ?? this.portada,
      name: name ?? this.name,
      actualizado: actualizado ?? this.actualizado,
      isTemporal: isTemporal ?? this.isTemporal,
      zoom: zoom ?? this.zoom,
      // isSelect: isSelect ?? this.isSelect,
    );
  }
}
