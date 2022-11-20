class AutorModel {
  final String key;
  final String nombre;

  AutorModel(this.key, this.nombre);
  factory AutorModel.fromApi(Map<String, dynamic> data) {
    return AutorModel(
      data["key"],
      data["nombre"],
    );
  }
}
