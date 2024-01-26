import 'dart:async';
import 'dart:io';

import 'package:easy_crypt/src/rust/api/crypt.dart' as crypt;
import 'package:easy_crypt/isar/database.dart';
import 'package:easy_crypt/isar/files.dart';
import 'package:easy_crypt/isar/transfer_records.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../models/records_state.dart';

class RecordsNotifier extends AutoDisposeAsyncNotifier<RecordsState> {
  final IsarDatabase database = IsarDatabase();

  static const pageSize = 10;

  @override
  FutureOr<RecordsState> build() async {
    List<Files> logs =
        await database.isar!.files.where().offset(0).limit(pageSize).findAll();
    return RecordsState(
        list: logs.map((e) {
      // print("e.transferRecords.toList()  ${e.transferRecords.toList().length}");
      return Record.fromModel(e, transferRecords: e.transferRecords.toList());
    }).toList());
  }

  newRecords(List<XFile> files, {bool useDefaultKey = true}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await database.isar!.writeTxn(() async {
        List<Files> records = [];
        for (final i in files) {
          Files record = Files();
          final b = await crypt.isEasyEncryptFile(p: i.path);

          if (!b) {
            if (useDefaultKey) {
              record.key = await crypt.defaultKey();
            } else {
              record.key = await crypt.randomKey();
            }
          } else {
            record.key = "";
          }

          record.filePath = i.path;
          record.jobType = !b ? JobType.encryption : JobType.decryption;
          records.add(record);
        }

        await database.isar!.files.putAll(records);
      });

      List<Files> records = await database.isar!.files
          .where()
          .offset(0)
          .limit(pageSize)
          .findAll();
      return RecordsState(
          list: records.map((e) => Record.fromModel(e)).toList());
    });
  }

  loadTransferLogs(String p) async {
    final item =
        state.value!.list.where((element) => element.savePath == p).firstOrNull;
    if (item != null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async {
        final records = await database.isar!.transferRecords
            .filter()
            .fromEqualTo(item.savePath)
            .sortByCreateAtDesc()
            .findAll();

        item.transferRecords = records;

        return state.value!.copyWith(null, null);
      });
    }
  }

  changeProgress(int id, double progress, {String? saved}) async {
    final item =
        state.value!.list.where((element) => element.id == id).firstOrNull;

    if (item != null) {
      if (saved != null) {
        item.savePath = saved;
        item.status = ProgressStatus.done;

        await database.isar!.writeTxn(() async {
          final record =
              await database.isar!.files.filter().idEqualTo(id).findFirst();
          if (record != null) {
            record.savePath = saved;
            await database.isar!.files.put(record);
          }
        });
      } else {
        item.status = ProgressStatus.onProgress;
      }

      item.progress = progress;
    }
    state = AsyncValue.data(state.value!.copyWith(null, null));
  }

  removeFile(Record f) async {
    if (f.savePath == null) {
      return;
    }
    File file = File(f.savePath!);
    if (file.existsSync()) {
      file.deleteSync();
    }

    await database.isar!.writeTxn(() async {
      final record =
          await database.isar!.files.filter().idEqualTo(f.id).findFirst();
      if (record != null) {
        record.savePath = null;
        await database.isar!.files.put(record);
      }
    });

    if (state.value!.list.map((e) => e.id == f.id).isNotEmpty) {
      // exists in list, should repaint
      state = await AsyncValue.guard(() async {
        List<Files> logs = await database.isar!.files
            .where()
            .offset((state.value!.pageId - 1) * pageSize)
            .limit(pageSize)
            .findAll();
        return RecordsState(
            list: logs.map((e) => Record.fromModel(e)).toList());
      });
    }
  }

  setKey(int id, String key) async {
    final f = await database.isar!.files.filter().idEqualTo(id).findFirst();

    if (f != null) {
      state = const AsyncLoading();
      f.key = key;

      state = await AsyncValue.guard(() async {
        await database.isar!.writeTxn(() async {
          await database.isar!.files.put(f);
        });
        return state.value!.copyWith(null, null);
      });
    }
  }

  removeRecord(Record f, {bool removeEncryptedFile = false}) async {
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
      await database.isar!.files.delete(f.id);
    });

    if (state.value!.list.map((e) => e.id == f.id).isNotEmpty) {
      // exists in list, should repaint
      state = await AsyncValue.guard(() async {
        List<Files> records = await database.isar!.files
            .where()
            .offset((state.value!.pageId - 1) * pageSize)
            .limit(pageSize)
            .findAll();
        return RecordsState(
            list: records.map((e) => Record.fromModel(e)).toList());
      });
    }
  }

  prevPage() async {
    if (state.value!.pageId == 1) {
      return;
    }
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      List<Files> records = await database.isar!.files
          .where()
          .offset((state.value!.pageId - 2) * pageSize)
          .limit(pageSize)
          .findAll();
      return RecordsState(
          list: records
              .map((e) => Record.fromModel(e,
                  transferRecords: e.transferRecords.toList()))
              .toList(),
          pageId: state.value!.pageId - 1);
    });
  }

  nextPage() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      List<Files> records = await database.isar!.files
          .where()
          .offset((state.value!.pageId) * pageSize)
          .limit(pageSize)
          .findAll();
      return RecordsState(
          list: records
              .map((e) => Record.fromModel(e,
                  transferRecords: e.transferRecords.toList()))
              .toList(),
          pageId: state.value!.pageId + 1);
    });
  }
}

final recordsProvider =
    AutoDisposeAsyncNotifierProvider<RecordsNotifier, RecordsState>(() {
  return RecordsNotifier();
});
