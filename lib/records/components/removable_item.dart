import 'dart:io';

import 'package:easy_crypt/style/app_style.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

class RemovableItem extends StatelessWidget {
  const RemovableItem({super.key, required this.file, this.onRemove});
  final XFile file;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    Widget icon = FileSystemEntity.isFileSync(file.path)
        ? Image.asset(
            "assets/icons/File.png",
            width: 40,
            height: 40,
          )
        : Image.asset(
            "assets/icons/Folder.png",
            width: 40,
            height: 40,
          );

    return Tooltip(
      message: file.path,
      waitDuration: const Duration(seconds: 1),
      child: Container(
        padding: const EdgeInsets.all(4),
        width: 55,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                offset: const Offset(0, 0),
                blurRadius: 3,
                spreadRadius: 3,
              ),
            ]),
        child: Stack(
          children: [
            Column(
              children: [
                icon,
                Text(
                  file.name,
                  maxLines: 1,
                  softWrap: true,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            Positioned(
                right: 1,
                top: 1,
                child: InkWell(
                  onTap: () {
                    if (onRemove != null) {
                      onRemove!();
                    }
                  },
                  child: const Icon(
                    Icons.remove_circle,
                    size: AppStyle.rowIconSize,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
