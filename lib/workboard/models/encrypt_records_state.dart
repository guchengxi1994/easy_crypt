import 'package:easy_crypt/isar/encrypt_logs.dart';

class EncryptRecordsState {
  List<EncryptRecord> list;
  int pageId;

  EncryptRecordsState({required this.list, this.pageId = 1});

  EncryptRecordsState copyWith(List<EncryptRecord>? list, int? pageId) {
    return EncryptRecordsState(
        list: list ?? this.list, pageId: pageId ?? this.pageId);
  }
}

enum EncryptStatus { onProgress, done, unstart }

class EncryptRecord {
  int id;
  int createAt;
  String? filePath;
  String? savePath;
  String? key;
  EncryptStatus status;
  double progress;

  EncryptRecord(
      {required this.createAt,
      required this.id,
      this.filePath,
      this.key,
      this.savePath,
      this.status = EncryptStatus.unstart,
      this.progress = 0});

  static EncryptRecord fromModel(EncryptLogs logs) {
    return EncryptRecord(
        createAt: logs.createAt,
        id: logs.id,
        filePath: logs.filePath,
        savePath: logs.savePath,
        key: logs.key,
        progress: logs.savePath != null ? 0 : 1,
        status:
            logs.savePath != null ? EncryptStatus.done : EncryptStatus.unstart);
  }
}
