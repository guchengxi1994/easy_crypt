import 'package:easy_crypt/src/rust/process/transfer.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:flutter/material.dart';

class FileWidget extends StatefulWidget {
  const FileWidget({super.key, required this.entry, this.onDoubleClick});
  final Entry entry;
  final VoidCallback? onDoubleClick;

  @override
  State<FileWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    Widget icon;
    if (widget.entry.type == EntryType.file) {
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
        if (widget.onDoubleClick != null) {
          widget.onDoubleClick!();
        }
      },
      child: MouseRegion(
        onEnter: (event) {
          if (isHovering) {
            return;
          }

          setState(() {
            isHovering = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHovering = false;
          });
        },
        cursor: SystemMouseCursors.click,
        child: Tooltip(
          message: widget.entry.path,
          waitDuration: const Duration(seconds: 1),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isHovering
                    ? AppStyle.appColor.withOpacity(0.3)
                    : Colors.transparent),
            height: 75,
            width: 75,
            child: Column(
              children: [
                icon,
                Text(
                  widget.entry.path,
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
