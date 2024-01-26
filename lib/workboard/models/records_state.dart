import 'package:easy_crypt/isar/files.dart';
import 'package:easy_crypt/isar/transfer_records.dart';

class RecordsState {
  List<Record> list;
  int pageId;

  RecordsState({required this.list, this.pageId = 1});

  RecordsState copyWith(List<Record>? list, int? pageId) {
    return RecordsState(list: list ?? this.list, pageId: pageId ?? this.pageId);
  }
}

enum ProgressStatus { onProgress, done, unstart }

class Record {
  int id;
  int createAt;
  String? filePath;
  String? savePath;
  String? key;
  ProgressStatus status;
  double progress;
  List<TransferRecords> transferRecords;
  bool isEncrypt;

  Record(
      {required this.createAt,
      required this.id,
      this.filePath,
      this.key,
      this.savePath,
      this.status = ProgressStatus.unstart,
      this.progress = 0,
      this.transferRecords = const [],
      this.isEncrypt = false});

  static Record fromModel(Files file,
      {List<TransferRecords>? transferRecords}) {
    return Record(
        createAt: file.createAt,
        id: file.id,
        filePath: file.filePath,
        savePath: file.savePath,
        key: file.key,
        progress: file.savePath != null ? 0 : 1,
        status: file.savePath != null
            ? ProgressStatus.done
            : ProgressStatus.unstart,
        transferRecords: transferRecords ?? [],
        isEncrypt: file.jobType == JobType.decryption);
  }
}
