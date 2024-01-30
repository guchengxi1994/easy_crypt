// ignore_for_file: constant_identifier_names

import 'package:easy_crypt/isar/database.dart';
import 'package:easy_crypt/isar/datasource.dart';
import 'package:easy_crypt/records/components/icons.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
part 'process_records.g.dart';

/// job type
enum JobType { encrypt, decrypt, encryptAndTransfer, transfer }

extension ToStr on JobType {
  String toStr() {
    switch (this) {
      case JobType.decrypt:
        return "decrypt";
      case JobType.encrypt:
        return "encrypt";
      case JobType.encryptAndTransfer:
        return "encryptAndTransfer";
      case JobType.transfer:
        return "transfer";
      default:
        return "decrypt";
    }
  }

  Widget toWidget() {
    switch (this) {
      case JobType.decrypt:
        return ProcessTypeIcons.decrypt();
      case JobType.encrypt:
        return ProcessTypeIcons.encrypt();
      case JobType.encryptAndTransfer:
        return ProcessTypeIcons.encryptAndTransfer();
      case JobType.transfer:
        return ProcessTypeIcons.transfer();
      default:
        return ProcessTypeIcons.encrypt();
    }
  }
}

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

  Datasource? getByDatasourceId(IsarDatabase database) {
    return database.isar!.datasources
        .where()
        .idEqualTo(datasourceId ?? 0)
        .findFirstSync();
  }
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

  Datasource? getFrom(IsarDatabase database) {
    return database.isar!.datasources
        .where()
        .idEqualTo(fromDatasourceId ?? 0)
        .findFirstSync();
  }

  Datasource? getTo(IsarDatabase database) {
    return database.isar!.datasources
        .where()
        .idEqualTo(toDatasourceId ?? 0)
        .findFirstSync();
  }
}
