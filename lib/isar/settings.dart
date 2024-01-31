import 'package:isar/isar.dart';

part 'settings.g.dart';

@collection
class Settings {
  int createAt = DateTime.now().millisecondsSinceEpoch;

  Id id = Isar.autoIncrement;

  String? key;
}
