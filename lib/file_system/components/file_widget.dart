import 'package:easy_crypt/isar/datasource.dart';
import 'package:easy_crypt/src/rust/process/datasource.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';

class FileWidget extends StatefulWidget {
  const FileWidget(
      {super.key,
      required this.entry,
      this.onDoubleClick,
      this.draggable = false,
      required this.datasourceType,
      this.onCopyPath,
      this.onCopyUrl});
  final Entry entry;
  final VoidCallback? onDoubleClick;
  final bool draggable;
  final DatasourceType datasourceType;
  final VoidCallback? onCopyPath;
  final VoidCallback? onCopyUrl;

  @override
  State<FileWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    if (widget.draggable) {
      return Draggable(
          data: widget.entry,
          feedback: Container(
            width: 20,
            height: 20,
            color: Colors.amber,
          ),
          childWhenDragging: Opacity(
            opacity: 0.5,
            child: SizedBox(
              width: 75,
              height: 75,
              child: _icon(),
            ),
          ),
          child: _child());
    }
    return _child();
  }

  Widget _icon() {
    Widget icon;
    List<String> paths = widget.entry.path.split("/")..remove("");
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
    return Column(
      children: [
        icon,
        Text(
          paths.length >= 2 ? paths[paths.length - 1] : paths.last,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  Widget _child() {
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
          child: ContextMenuRegion(
              menuType: MenuType.desktop,
              contextMenu: ContextMenu(entries: [
                MenuItem(
                  label: 'Encrypt',
                  icon: const Icon(Icons.lock),
                  onSelected: () {},
                ),
                MenuItem(
                  label: 'Decrypt',
                  icon: const Icon(Icons.lock_open),
                  onSelected: () {},
                ),
                if (widget.datasourceType == DatasourceType.Local)
                  MenuItem(
                    label: 'Copy path',
                    icon: const Icon(Icons.file_copy),
                    onSelected: () {
                      if (widget.onCopyPath != null) {
                        widget.onCopyPath!();
                      }
                    },
                  ),
                if (widget.datasourceType == DatasourceType.S3)
                  MenuItem(
                    label: 'Copy link',
                    icon: const Icon(Icons.link),
                    onSelected: () {
                      if (widget.onCopyUrl != null) {
                        widget.onCopyUrl!();
                      }
                    },
                  ),
                if (widget.datasourceType == DatasourceType.S3)
                  MenuItem(
                    label: 'Fetch',
                    icon: const Icon(Icons.download),
                    onSelected: () {},
                  ),
              ]),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: isHovering
                        ? AppStyle.appColor.withOpacity(0.3)
                        : Colors.transparent),
                height: 75,
                width: 75,
                child: _icon(),
              )),
        ),
      ),
    );
  }
}
