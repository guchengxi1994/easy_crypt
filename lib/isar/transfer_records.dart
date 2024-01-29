// ignore_for_file: constant_identifier_names

import 'package:easy_crypt/isar/datasource.dart';
import 'package:isar/isar.dart';
part 'transfer_records.g.dart';

enum StorageType { S3, Webdav, Local }

@collection
class TransferRecords {
  Id id = Isar.autoIncrement;
  @enumerated
  late StorageType fromType;
  String? from;
  @enumerated
  late StorageType toType;
  String? to;

  final fromDatasource = IsarLink<Datasource>();
  final toDatasource = IsarLink<Datasource>();
  int createAt = DateTime.now().millisecondsSinceEpoch;

  // transfer done?
  late bool done = false;
}
