import 'dart:async';
import 'dart:io';

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

  changeProgress(int id, double progress, {String? saved}) async {
    final item =
        state.value!.list.where((element) => element.id == id).firstOrNull;

    if (item != null) {
      if (saved != null) {
        item.savePath = saved;
        item.status = EncryptStatus.done;

        await database.isar!.writeTxn(() async {
          final log = await database.isar!.encryptLogs
              .filter()
              .idEqualTo(id)
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

  removeEncryptedFile(EncryptRecord f) async {
    if (f.savePath == null) {
      return;
    }
    File file = File(f.savePath!);
    if (file.existsSync()) {
      file.deleteSync();
    }

    await database.isar!.writeTxn(() async {
      final log =
          await database.isar!.encryptLogs.filter().idEqualTo(f.id).findFirst();
      if (log != null) {
        log.savePath = null;
        await database.isar!.encryptLogs.put(log);
      }
    });

    if (state.value!.list.map((e) => e.id == f.id).isNotEmpty) {
      // exists in list, should repaint
      state = await AsyncValue.guard(() async {
        List<EncryptLogs> logs = await database.isar!.encryptLogs
            .where()
            .offset((state.value!.pageId - 1) * 10)
            .limit(10)
            .findAll();
        return EncryptRecordsState(
            list: logs.map((e) => EncryptRecord.fromModel(e)).toList());
      });
    }
  }

  removeLog(EncryptRecord f, {bool removeEncryptedFile = false}) async {
    if (removeEncryptedFile) {
      if (f.savePath == null) {
        return;
      }
      File file = File(f.savePath!);
      if (file.existsSync()) {
        file.deleteSync();
      }
    }

    await database.isar!.writeTxn(() async {
      await database.isar!.encryptLogs.delete(f.id);
    });

    if (state.value!.list.map((e) => e.id == f.id).isNotEmpty) {
      // exists in list, should repaint
      state = await AsyncValue.guard(() async {
        List<EncryptLogs> logs = await database.isar!.encryptLogs
            .where()
            .offset((state.value!.pageId - 1) * 10)
            .limit(10)
            .findAll();
        return EncryptRecordsState(
            list: logs.map((e) => EncryptRecord.fromModel(e)).toList());
      });
    }
  }
}

final encryptRecordsProvider = AutoDisposeAsyncNotifierProvider<
    EncryptRecordsNotifier, EncryptRecordsState>(() {
  return EncryptRecordsNotifier();
});
