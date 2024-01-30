import 'dart:async';

import 'package:easy_crypt/isar/datasource.dart';
import 'package:easy_crypt/isar/database.dart';
import 'package:easy_crypt/isar/files.dart';
import 'package:easy_crypt/isar/process_records.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../models/records_state.dart';

class RecordsNotifier extends AutoDisposeAsyncNotifier<RecordsState> {
  final IsarDatabase database = IsarDatabase();

  static const pageSize = 10;

  @override
  FutureOr<RecordsState> build() async {
    final list = await database.isar!.processRecords
        .where()
        .offset(0)
        .limit(pageSize)
        .findAll();

    return RecordsState(list: list);
  }

  /*
      transfer files between 2 datasources
  */
  newTwoDatasourceRecords(String from, String to, Datasource fromDatasource,
      Datasource toDatasource,
      {String? key}) async {
    TransferConfig transferConfig = TransferConfig()
      ..from = from
      ..to = to
      ..key = key
      ..fromDatasourceId = fromDatasource.id
      ..toDatasourceId = toDatasource.id;

    ProcessRecords processRecords = ProcessRecords()
      ..done = true
      ..jobType = key == null ? JobType.transfer : JobType.encryptAndTransfer
      ..transferConfig = transferConfig;

    Files files = Files()
      ..filePath = from
      ..datasource.value = fromDatasource
      ..transferRecords.add(processRecords);

    await database.isar!.writeTxn(() async {
      await database.isar!.processRecords.put(processRecords);
      await database.isar!.files.put(files);

      await files.datasource.save();
      await files.transferRecords.save();
    });
  }

  changeProgress(int id, double progress, {String? saved}) async {}

  removeRecord(ProcessRecords f) async {
    if (state.value!.list.map((e) => e.id == f.id).isNotEmpty) {
      // exists in list, should repaint
      state = await AsyncValue.guard(() async {
        List<ProcessRecords> records = await database.isar!.processRecords
            .where()
            .offset((state.value!.pageId - 1) * pageSize)
            .limit(pageSize)
            .findAll();
        return RecordsState(list: records);
      });
    }
  }

  prevPage() async {
    if (state.value!.pageId == 1) {
      return;
    }
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      List<ProcessRecords> records = await database.isar!.processRecords
          .where()
          .offset((state.value!.pageId - 2) * pageSize)
          .limit(pageSize)
          .findAll();
      return RecordsState(list: records, pageId: state.value!.pageId - 1);
    });
  }

  nextPage() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      List<ProcessRecords> records = await database.isar!.processRecords
          .where()
          .offset((state.value!.pageId) * pageSize)
          .limit(pageSize)
          .findAll();
      return RecordsState(list: records, pageId: state.value!.pageId + 1);
    });
  }
}

final recordsProvider =
    AutoDisposeAsyncNotifierProvider<RecordsNotifier, RecordsState>(() {
  return RecordsNotifier();
});
