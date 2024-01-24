// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.21.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

class EncryptItem {
  final String filePath;
  final int fileId;

  const EncryptItem({
    required this.filePath,
    required this.fileId,
  });

  @override
  int get hashCode => filePath.hashCode ^ fileId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EncryptItem &&
          runtimeType == other.runtimeType &&
          filePath == other.filePath &&
          fileId == other.fileId;
}