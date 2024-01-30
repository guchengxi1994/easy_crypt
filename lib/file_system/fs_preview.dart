import 'package:easy_crypt/datasource/notifiers/datasource_notifier.dart';
import 'package:easy_crypt/file_system/enum.dart';
import 'package:easy_crypt/file_system/local.dart';
import 'package:easy_crypt/file_system/s3.dart';
import 'package:easy_crypt/gen/strings.g.dart';
import 'package:easy_crypt/isar/datasource.dart';
import 'package:easy_crypt/layout/notifiers/setting_notifier.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  late String txt = t.workboard.title;

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(settingsNotifier);

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
                      if (v.datasourceType == DatasourceType.Local) {
                        if (v.localConfig!.path == "selecting") {
                          final String? directoryPath =
                              await getDirectoryPath();
                          if (directoryPath == null) {
                            return;
                          }
                          LocalConfig localConfig = LocalConfig()
                            ..path = directoryPath;
                          // 新建 本地数据源
                          final d = Datasource()
                            ..datasourceType = DatasourceType.Local
                            ..localConfig = localConfig
                            ..name = directoryPath;

                          ref
                              .read(datasourceProvider.notifier)
                              .addDatasource(d);

                          if (widget.previewType == PreviewType.Left) {
                            ref.read(cachedProvider.notifier).setLeft(d);
                          } else {
                            ref.read(cachedProvider.notifier).setRight(d);
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
                          if (widget.previewType == PreviewType.Left) {
                            ref.read(cachedProvider.notifier).setLeft(v);
                          } else {
                            ref.read(cachedProvider.notifier).setRight(v);
                          }

                          setState(() {
                            txt = "Local:  ${v.localConfig?.path}";
                            child = LocalFilePreview(
                              path: v.localConfig!.path!,
                              previewType: widget.previewType,
                              width: widget.width,
                              height: widget.height,
                            );
                          });
                        }

                        return;
                      }

                      if (v.datasourceType == DatasourceType.S3) {
                        if (widget.previewType == PreviewType.Left) {
                          ref.read(cachedProvider.notifier).setLeft(v);
                        } else {
                          ref.read(cachedProvider.notifier).setRight(v);
                        }

                        setState(() {
                          txt = "Remote:  ${v.name}";
                          child = S3FilePreview(
                              previewType: widget.previewType,
                              accesskey: v.s3config!.accesskey!,
                              bucketname: v.s3config!.bucketname!,
                              endpoint: v.s3config!.endpoint!,
                              sessionToken: v.s3config!.sessionToken,
                              sessionkey: v.s3config!.sessionKey!);
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
