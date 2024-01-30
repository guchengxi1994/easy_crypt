import 'package:easy_crypt/file_system/enum.dart';
import 'package:easy_crypt/file_system/notifiers/cached_datasource_notifier.dart';
import 'package:easy_crypt/file_system/notifiers/local_notifier.dart';
import 'package:easy_crypt/isar/datasource.dart';
import 'package:easy_crypt/src/rust/api/datasource.dart' as ds;
import 'package:easy_crypt/src/rust/process/datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_clipboard/super_clipboard.dart';

import 'components/file_widget.dart';
import 'components/title_bar.dart';
import 'models/local_state.dart';

class LocalFilePreview extends ConsumerWidget {
  LocalFilePreview(
      {super.key,
      this.width,
      this.height,
      this.previewType,
      required this.path});
  final double? width;
  final double? height;
  final PreviewType? previewType;
  final String path;
  late final localNotifier = AutoDisposeAsyncNotifierProvider.family<
      LocalNotifier, LocalState, String>(
    () {
      print("path   $path");
      return LocalNotifier(path: path, previewType: previewType);
    },
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(localNotifier(path));

    return switch (state) {
      AsyncValue<LocalState>(:final value?) => Material(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            // padding: const EdgeInsets.all(20),
            width: width ?? 0.8 * MediaQuery.of(context).size.width,
            height: height ?? 0.8 * MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.white),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      Expanded(
                          child: TitleBar(
                        routers: value.routers,
                        onPrevClick: () {
                          if (previewType == null) {
                            return;
                          }
                          ref
                              .read(localNotifier(path).notifier)
                              .prev(previewType == PreviewType.Left ? 1 : 0);
                        },
                        onRefreshClick: () {
                          if (previewType == null) {
                            return;
                          }
                          ref.read(localNotifier(path).notifier).refreshCurrent(
                              previewType == PreviewType.Left ? 1 : 0);
                        },
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: _buildContent(value.entries, ref))
              ],
            ),
          ),
        ),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }

  final clipboard = SystemClipboard.instance;

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
          const Text("Select a folder first")
        ],
      );
    }

    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: entries
              .map((e) => FileWidget(
                    onCopyPath: () async {
                      if (clipboard == null) {
                        return;
                      }
                      final item = DataWriterItem();

                      final p =
                          "${ref.read(localNotifier(path).notifier).path}/${e.path}";
                      item.add(Formats.fileUri(Uri.file(p)));
                      await clipboard!.write([item]);
                    },
                    datasourceType: DatasourceType.Local,
                    draggable: previewType == PreviewType.Left,
                    entry: e,
                    onDoubleClick: () async {
                      if (e.type == EntryType.folder) {
                        if (previewType == PreviewType.Left) {
                          final left =
                              ref.read(cachedProvider.notifier).findLeft();

                          if (left != null) {
                            final list = await ds.listObjectsLeft(p: e.path);

                            if (list.isNotEmpty) {
                              ref
                                  .read(localNotifier(path).notifier)
                                  .refresh(list, e.path);
                            }
                          }
                        }
                        if (previewType == PreviewType.Right) {
                          final right =
                              ref.read(cachedProvider.notifier).findRight();

                          if (right != null) {
                            final list = await ds.listObjectsRight(p: e.path);
                            if (list.isNotEmpty) {
                              ref
                                  .read(localNotifier(path).notifier)
                                  .refresh(list, e.path);
                            }
                          }
                        }
                      }
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
