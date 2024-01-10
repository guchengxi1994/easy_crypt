import 'package:flutter/services.dart';

Future copyToClipboard(String text) async {
  await Clipboard.setData(ClipboardData(text: text));
}
