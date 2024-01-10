import 'dart:async';

import 'package:easy_crypt/bridge/native.dart';
import 'package:easy_crypt/isar/database.dart';
import 'package:easy_crypt/isar/encrypt_logs.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../models/encrypt_records_state.dart';

class EncryptRecordsNotifier
    extends AutoDisposeAsyncNotifier<EncryptRecordsState> {
  final IsarDatabase database = IsarDatabase();

  @override
  FutureOr<EncryptRecordsState> build() async {
    List<EncryptLogs> logs =
        await database.isar!.encryptLogs.where().offset(0).limit(10).findAll();
    return EncryptRecordsState(
        list: logs.map((e) => EncryptRecord.fromModel(e)).toList());
  }

  newRecords(List<XFile> files, {bool useDefaultKey = true}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await database.isar!.writeTxn(() async {
        List<EncryptLogs> logs = [];
        for (final i in files) {
          EncryptLogs log = EncryptLogs();
          if (useDefaultKey) {
            log.key = await api.defaultKey();
          } else {
            log.key = await api.randomKey();
          }

          log.filePath = i.path;

          logs.add(log);
        }

        await database.isar!.encryptLogs.putAll(logs);
      });

      List<EncryptLogs> logs = await database.isar!.encryptLogs
          .where()
          .offset(0)
          .limit(10)
          .findAll();
      return EncryptRecordsState(
          list: logs.map((e) => EncryptRecord.fromModel(e)).toList());
    });
  }

  changeProgress(String filepath, double progress,
      {String? uuid, String? saved}) async {
    final item = state.value!.list
        .where((element) => element.filePath == filepath)
        .firstOrNull;

    if (item != null) {
      if (saved != null) {
        item.savePath = saved;
        item.status = EncryptStatus.done;

        await database.isar!.writeTxn(() async {
          final log = await database.isar!.encryptLogs
              .filter()
              .filePathEqualTo(filepath)
              .findFirst();
          if (log != null) {
            log.savePath = saved;
            await database.isar!.encryptLogs.put(log);
          }
        });
      } else {
        item.status = EncryptStatus.onProgress;
      }

      item.progress = progress;
    }
    state = AsyncValue.data(state.value!.copyWith(null, null));
  }
}

final encryptRecordsProvider = AutoDisposeAsyncNotifierProvider<
    EncryptRecordsNotifier, EncryptRecordsState>(() {
  return EncryptRecordsNotifier();
});
