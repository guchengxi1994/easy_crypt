import 'package:easy_crypt/isar/files.dart';
import 'package:easy_crypt/isar/process_records.dart';

class RecordsState {
  List<ProcessRecords> list;
  int pageId;

  RecordsState({required this.list, this.pageId = 1});

  RecordsState copyWith(List<ProcessRecords>? list, int? pageId) {
    return RecordsState(list: list ?? this.list, pageId: pageId ?? this.pageId);
  }
}

enum ProgressStatus { onProgress, done, unstart }

@Deprecated("remove later")
class Record {
  int id;
  int createAt;
  String? filePath;
  String? savePath;
  String? key;
  ProgressStatus status;
  double progress;
  List<ProcessRecords> proccessRecords;
  bool isEncrypt;

  Record(
      {required this.createAt,
      required this.id,
      this.filePath,
      this.key,
      this.savePath,
      this.status = ProgressStatus.unstart,
      this.progress = 0,
      this.proccessRecords = const [],
      this.isEncrypt = false});

  static Record fromModel(Files file, {List<ProcessRecords>? processRecords}) {
    return Record(
        createAt: file.createAt,
        id: file.id,
        filePath: file.filePath,
        savePath: "",
        key: "",
        progress: 1,
        status: ProgressStatus.unstart,
        proccessRecords: processRecords ?? [],
        isEncrypt: false);
  }
}
