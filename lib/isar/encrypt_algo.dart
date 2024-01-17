import 'package:isar/isar.dart';

part 'encrypt_algo.g.dart';

@collection
class EncryptAlgorithm {
  Id id = Isar.autoIncrement;
  int createAt = DateTime.now().millisecondsSinceEpoch;

  String? content;
}
