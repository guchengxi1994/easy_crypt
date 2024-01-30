import 'package:easy_crypt/isar/datasource.dart';
import 'package:easy_crypt/isar/process_records.dart';
import 'package:isar/isar.dart';

part 'files.g.dart';

/// files to encrypt and decrypt
@collection
class Files {
  Id id = Isar.autoIncrement;
  int createAt = DateTime.now().millisecondsSinceEpoch;
  String? filePath;

  final datasource = IsarLink<Datasource>();

  final transferRecords = IsarLinks<ProcessRecords>();
}
