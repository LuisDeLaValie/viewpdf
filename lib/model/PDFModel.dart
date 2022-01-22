import 'package:hive/hive.dart';
part 'PDFModel.g.dart';

@HiveType(typeId: 1)
class PDFModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  int page;
  @HiveField(2)
  String path;
  @HiveField(3)
  String name;
  @HiveField(4)
  DateTime actualizado;
  @HiveField(5)
  bool isTemporal;
  @HiveField(6)
  double zoom;

  PDFModel({
    this.id = "",
    this.page = 0,
    this.path = "",
    required this.name,
    required this.actualizado,
    this.isTemporal = true,
    this.zoom = 1,
  });

  
  @override
  String toString() {
    return 'PDFModel(id: $id)';
  }
}
