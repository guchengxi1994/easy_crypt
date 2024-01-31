import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_clipboard/super_clipboard.dart';

class ClipboardUtils {
  static final clipboard = SystemClipboard.instance;
  ClipboardUtils._();

  static copyUrl(String path, {VoidCallback? onDone}) async {
    if (clipboard == null) {
      return;
    }
    final item = DataWriterItem();
    item.add(Formats.fileUri(Uri.file(path)));
    await clipboard!.write([item]);

    if (onDone != null) {
      onDone();
    }
  }

  static copyText(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
