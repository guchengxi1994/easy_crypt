// ignore_for_file: constant_identifier_names

import 'package:isar/isar.dart';
part 'process_records.g.dart';

/// job type
enum JobType { encrypt, decrypt, encryptAndTransfer, transfer }

@collection
class ProcessRecords {
  @enumerated
  late JobType jobType;
  int createAt = DateTime.now().millisecondsSinceEpoch;

  Id id = Isar.autoIncrement;
  CryptConfig? encryptConfig;
  CryptConfig? decryptConfig;
  TransferConfig? transferConfig;

  // transfer done?
  late bool done = false;
}

@embedded
class CryptConfig {
  // final datasource = IsarLink<Datasource>();
  int? datasourceId;
  String? path;
  // save to same datasource
  String? savedPath;
  String? key;
}

@embedded
class TransferConfig {
  String? from;
  String? to;

  // final fromDatasource = IsarLink<Datasource>();
  int? fromDatasourceId;
  // final toDatasource = IsarLink<Datasource>();
  int? toDatasourceId;

  /// only support encrypt
  String? key;
}
