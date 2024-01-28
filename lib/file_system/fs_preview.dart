import 'package:easy_crypt/file_system/enum.dart';
import 'package:easy_crypt/file_system/local.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/datasource_selection.dart';

class FsPreview extends ConsumerStatefulWidget {
  const FsPreview(
      {super.key, this.width, this.height, required this.previewType});
  final double? width;
  final double? height;
  final PreviewType previewType;

  @override
  ConsumerState createState() => _FsPreviewState();
}

class _FsPreviewState extends ConsumerState<FsPreview> {
  late Widget child = Container();
  late String txt = "Choose a datasource or select a folder";

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: widget.width ?? 0.8 * MediaQuery.of(context).size.width,
        height: widget.height ?? 0.8 * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    txt,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  )),
                  DatasourceSelection(
                    onItemSelect: (v) async {
                      if (v.name == "Add local path...") {
                        final String? directoryPath = await getDirectoryPath();
                        if (directoryPath == null) {
                          return;
                        }

                        setState(() {
                          txt = "Local:  $directoryPath";
                          child = LocalFilePreview(
                            path: directoryPath,
                            previewType: widget.previewType,
                            width: widget.width,
                            height: widget.height,
                          );
                        });
                      } else {
                        setState(() {
                          txt = "Remote:  ${v.name}";
                        });
                      }
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: child)
          ],
        ),
      ),
    );
  }
}
