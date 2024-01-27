import 'package:easy_crypt/file_system/notifiers/cached_datasource_notifier.dart';
import 'package:easy_crypt/src/rust/api/datasource.dart' as ds;
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/datasource_selection.dart';

class LocalFilePreview extends ConsumerWidget {
  const LocalFilePreview({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      ref.read(cachedProvider.notifier).add(i, directoryPath);
                      final list =
                          await ds.listObjectsByIndex(index: i, p: "/");

                      print(list.length);
                    },
                    child: Icon(Icons.folder),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
