class CompressState {
  List<CompressJob> jobs;

  CompressState({required this.jobs});
}

class CompressJob {
  int? total;
  int? current;
  String? currentFilePath;
}
