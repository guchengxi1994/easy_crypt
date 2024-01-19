class JobState<T extends Job> {
  List<T> jobs;

  JobState({required this.jobs});
}

class CompressJob extends Job {
  int? total;
  int? current;
  String? currentFilePath;
}

class UploadJob extends Job {
  String? filePath;
  String? transferSpeed;
  double? progress;
  String? errorMsg;

  static UploadJob fromJson(Map<String, dynamic> map) {
    return UploadJob()
      ..filePath = map["file_path"]
      ..progress = map["progress"]
      ..transferSpeed = map["transfer_speed"]
      ..errorMsg = map["error_msg"];
  }

  @override
  bool operator ==(Object other) {
    if (other is! UploadJob) {
      return false;
    }
    return other.filePath == filePath;
  }

  @override
  int get hashCode => filePath.hashCode;
}

abstract class Job {}
