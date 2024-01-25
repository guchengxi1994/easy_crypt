import 'package:easy_crypt/src/rust/process/transfer.dart';
import 'package:flutter/material.dart';

class FileWidget extends StatelessWidget {
  const FileWidget({super.key, required this.entry, this.onDoubleClick});
  final Entry entry;
  final VoidCallback? onDoubleClick;

  @override
  Widget build(BuildContext context) {
    Widget icon;
    if (entry.type == EntryType.file) {
      icon = SizedBox(
        width: 48,
        height: 48,
        child: Image.asset("assets/icons/File.png"),
      );
    } else {
      icon = SizedBox(
        width: 48,
        height: 48,
        child: Image.asset("assets/icons/Folder.png"),
      );
    }

    return GestureDetector(
      onDoubleTap: () {
        if (onDoubleClick != null) {
          onDoubleClick!();
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Tooltip(
          message: entry.path,
          waitDuration: const Duration(seconds: 1),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            height: 75,
            width: 75,
            child: Column(
              children: [
                icon,
                Text(
                  entry.path,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
