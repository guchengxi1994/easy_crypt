import 'package:easy_crypt/records/components/removable_item.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

class MultipleFilesDialog extends StatefulWidget {
  const MultipleFilesDialog({super.key, required this.files});
  final List<XFile> files;

  @override
  State<MultipleFilesDialog> createState() => _MultipleFilesDialogState();
}

class _MultipleFilesDialogState extends State<MultipleFilesDialog> {
  late List<XFile> files = widget.files;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        width: 300,
        height: 400,
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
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: 250,
              child: Wrap(
                runSpacing: 8,
                spacing: 8,
                children: files
                    .map((e) => RemovableItem(
                          file: e,
                          onRemove: () {
                            files.remove(e);
                            setState(() {});
                          },
                        ))
                    .toList(),
              ),
            ),
            const Expanded(child: SizedBox()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {}, child: const Text("压缩为一个文件")),
                TextButton(onPressed: () {}, child: const Text("存储为多个文件"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
