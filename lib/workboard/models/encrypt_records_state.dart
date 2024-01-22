import 'package:easy_crypt/isar/files.dart';
import 'package:easy_crypt/isar/transfer_records.dart';

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
  List<TransferRecords> transferRecords;

  EncryptRecord(
      {required this.createAt,
      required this.id,
      this.filePath,
      this.key,
      this.savePath,
      this.status = EncryptStatus.unstart,
      this.progress = 0,
      this.transferRecords = const []});

  static EncryptRecord fromModel(Files file,
      {List<TransferRecords>? transferRecords}) {
    return EncryptRecord(
        createAt: file.createAt,
        id: file.id,
        filePath: file.filePath,
        savePath: file.savePath,
        key: file.key,
        progress: file.savePath != null ? 0 : 1,
        status:
            file.savePath != null ? EncryptStatus.done : EncryptStatus.unstart,
        transferRecords: transferRecords ?? []);
  }
}
