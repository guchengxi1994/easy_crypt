import 'package:easy_crypt/file_system/enum.dart';
import 'package:easy_crypt/file_system/local.dart';
import 'package:easy_crypt/file_system/s3.dart';
import 'package:easy_crypt/isar/datasource.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:easy_crypt/src/rust/api/datasource.dart' as ds;

import 'components/datasource_selection.dart';
import 'notifiers/cached_datasource_notifier.dart';

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
      elevation: 10,
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

                        if (ref
                                .read(cachedProvider.notifier)
                                .index(directoryPath) ==
                            null) {
                          final i =
                              await ds.addLocalDatasource(p: directoryPath);
                          ref.read(cachedProvider.notifier).add(
                              i,
                              Tuple2(
                                  widget.previewType == PreviewType.Left
                                      ? CachedDatasourceType.Left
                                      : CachedDatasourceType.Right,
                                  v));
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
                      } else if (v.datasourceType == DatasourceType.S3) {
                        if (ref.read(cachedProvider.notifier).index(v) ==
                            null) {
                          final i = await ds.addS3Datasource(
                              region: v.region!,
                              accessKey: v.accesskey!,
                              bucketname: v.bucketname!,
                              endpoint: v.endpoint!,
                              sessionToken: v.sessionToken,
                              sessionKey: v.sessionKey!);
                          ref.read(cachedProvider.notifier).add(
                              i,
                              Tuple2(
                                  widget.previewType == PreviewType.Left
                                      ? CachedDatasourceType.Left
                                      : CachedDatasourceType.Right,
                                  v));
                        }

                        setState(() {
                          txt = "Remote:  ${v.name}";
                          child = S3FilePreview(
                              accesskey: v.accesskey!,
                              bucketname: v.bucketname!,
                              endpoint: v.endpoint!,
                              sessionToken: v.sessionToken,
                              sessionkey: v.sessionKey!);
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
