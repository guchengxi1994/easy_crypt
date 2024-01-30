class DecryptParamDialogModel {
  final String key;
  final String fileType;
  final bool saveKey;

  DecryptParamDialogModel(
      {this.saveKey = false, required this.fileType, required this.key});
}
