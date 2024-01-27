import 'dart:io';

import 'package:easy_crypt/file_system/enum.dart';
import 'package:easy_crypt/file_system/notifiers/cached_datasource_notifier.dart';
import 'package:easy_crypt/file_system/notifiers/local_notifier.dart';
import 'package:easy_crypt/src/rust/api/datasource.dart' as ds;
import 'package:easy_crypt/src/rust/process/datasource.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import 'components/datasource_selection.dart';
import 'components/file_widget.dart';

class LocalFilePreview extends ConsumerWidget {
  const LocalFilePreview(
      {super.key, this.width, this.height, this.previewType});
  final double? width;
  final double? height;
  final PreviewType? previewType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(localNotifier);

    return Material(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: width ?? 0.8 * MediaQuery.of(context).size.width,
        height: height ?? 0.8 * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: DatasourceSelection(
                onItemSelect: (v) {},
              ),
            ),
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  InkWell(
                    onTap: () async {
                      final String? directoryPath = await getDirectoryPath();
                      if (directoryPath == null) {
                        return;
                      }
                      final i = await ds.addLocalDatasource(p: directoryPath);
                      ref.read(cachedProvider.notifier).add(
                          i, Tuple2(CachedDatasourceType.Left, directoryPath));
                      final list =
                          await ds.listObjectsByIndex(index: i, p: "/");

                      // print(list.length);
                      if (list.isNotEmpty) {
                        ref
                            .read(localNotifier.notifier)
                            .refresh(list, directoryPath);
                      }
                    },
                    child: Icon(Icons.folder),
                  )
                ],
              ),
            ),
            Expanded(child: _buildContent(state.entries, ref))
          ],
        ),
      ),
    );
  }

  Widget _buildContent(List<Entry> entries, WidgetRef ref) {
    if (entries.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: 200,
            child: Image.asset("assets/images/nodata.png"),
          ),
          Text("Select a folder first")
        ],
      );
    }

    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: entries
            .map((e) => FileWidget(
                  entry: e,
                  onDoubleClick: () async {
                    if (e.type == EntryType.folder) {
                      if (previewType == PreviewType.Left) {
                        final left =
                            ref.read(cachedProvider.notifier).findLeft();
                        if (left != null) {
                          // String path = left.item2 + "\\" + e.path;

                          // if (Platform.isWindows) {
                          //   path = path.replaceAll("/", "\\");
                          // }

                          final list = await ds.listObjectsByIndex(
                              index: left.item1, p: e.path);

                          print(list.length);
                          if (list.isNotEmpty) {
                            ref
                                .read(localNotifier.notifier)
                                .refresh(list, left.item2);
                          }
                        }
                      }
                      if (previewType == PreviewType.Right) {
                        final right =
                            ref.read(cachedProvider.notifier).findRight();
                        if (right != null) {
                          final list = await ds.listObjectsByIndex(
                              index: right.item1, p: right.item2);
                          if (list.isNotEmpty) {
                            ref
                                .read(localNotifier.notifier)
                                .refresh(list, right.item2);
                          }
                        }
                      }
                    }
                  },
                ))
            .toList(),
      ),
    );
  }
}
