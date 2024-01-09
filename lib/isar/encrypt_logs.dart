import 'package:isar/isar.dart';

part 'encrypt_logs.g.dart';

@collection
class EncryptLogs {
  Id id = Isar.autoIncrement;
  int createAt = DateTime.now().millisecondsSinceEpoch;
  String? filePath;
  String? savePath;
  String? key;
}
