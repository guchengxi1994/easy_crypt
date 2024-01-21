// ignore_for_file: constant_identifier_names

import 'package:easy_crypt/isar/account.dart';
import 'package:isar/isar.dart';
part 'transfer_logs.g.dart';

enum StorageType { S3, Webdav, Local }

@collection
class TransferLogs {
  Id id = Isar.autoIncrement;
  @enumerated
  late StorageType fromType;
  String? from;
  @enumerated
  late StorageType toType;
  String? to;
  final account = IsarLink<Account>();
  int createAt = DateTime.now().millisecondsSinceEpoch;

  // transfer done?
  late bool done = false;
}
