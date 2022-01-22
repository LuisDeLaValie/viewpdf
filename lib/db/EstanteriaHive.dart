import 'package:hive/hive.dart';
import 'package:viewpdf/model/EstanteriaModel.dart';

class EstanteriaHive {
  EstanteriaHive._internal();
  static EstanteriaHive _instance = EstanteriaHive._internal();
  static EstanteriaHive get instance => EstanteriaHive._instance;

  String name = 'estanteria';

  late Box<EstanteriaModel> _box;
  Future<void> init() async {
    _box = await Hive.openBox<EstanteriaModel>(name);
  }

  Box<EstanteriaModel> get box => _box;
}
