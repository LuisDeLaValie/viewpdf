import 'dart:convert';

class EstanteriaModel {
  String key;
  String nombre;
  List<LibroEstanteria> libros;
  bool isColeection;
  
  EstanteriaModel({
    required this.key,
    required this.nombre,
    required this.libros,
    required this.isColeection,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'nombre': nombre,
      'libros': libros.map((x) => x.toMap()).toList(),
      'isColeection': isColeection,
    };
  }

  factory EstanteriaModel.fromMap(Map<String, dynamic> map) {
    return EstanteriaModel(
      key: map['key'] ?? '',
      nombre: map['nombre'] ?? '',
      libros: List<LibroEstanteria>.from(map['libros']?.map((x) => LibroEstanteria.fromMap(x))),
      isColeection: map['isColeection'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory EstanteriaModel.fromJson(String source) => EstanteriaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EstanteriaModel(key: $key, nombre: $nombre, libros: $libros, isColeection: $isColeection)';
  }
}

class LibroEstanteria {
  String key;
  String nombre;
  
  LibroEstanteria({
    required this.key,
    required this.nombre,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'nombre': nombre,
    };
  }

  factory LibroEstanteria.fromMap(Map<String, dynamic> map) {
    return LibroEstanteria(
      key: map['key'] ?? '',
      nombre: map['nombre'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LibroEstanteria.fromJson(String source) => LibroEstanteria.fromMap(json.decode(source));
}
