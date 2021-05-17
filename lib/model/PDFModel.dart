import 'package:flutter/material.dart';
import 'package:sembast/timestamp.dart';

class PDFModel {
  int id;
  int page;
  String path;
  String name;
  Timestamp actualizado;
  bool isTemporal;
  double zoom;

  PDFModel(
      {this.id,
      @required this.name,
      @required this.path,
      @required this.actualizado,
      this.page = 0,
      this.isTemporal = true,
      this.zoom = 1});

  static PDFModel fromJson(Map<String, dynamic> map) {
    return PDFModel(
      id: map['id'],
      page: map['page'],
      path: map['path'],
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
      'name': this.name,
      'actualizado': this.actualizado,
      'isTemporal': this.isTemporal,
      'zoom': this.zoom
    };
  }
}
