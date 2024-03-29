import 'package:easy_crypt/datasource/components/modify_datasource_dialog.dart';
import 'package:easy_crypt/datasource/notifiers/datasource_notifier.dart';
import 'package:easy_crypt/file_system/s3.dart';
import 'package:easy_crypt/isar/datasource.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatasourceWidget extends ConsumerWidget {
  const DatasourceWidget({super.key, required this.datasource});
  final Datasource datasource;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (datasource.datasourceType == DatasourceType.S3) {
      return Container(
        width: 300,
        height: 350,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                offset: const Offset(0, 0),
                blurRadius: 5,
                spreadRadius: 5,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all()),
                  width: 40,
                  height: 40,
                  child: const Center(
                    child: Icon(Icons.storage),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  datasource.name ?? "",
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                InkWell(
                  child: const Icon(
                    Icons.preview,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    showGeneralDialog(
                        barrierDismissible: true,
                        barrierLabel: "s3preview",
                        context: context,
                        pageBuilder: (c, _, __) {
                          return Center(
                            child: S3FilePreview(
                                isDialog: true,
                                accesskey: datasource.s3config!.accesskey!,
                                bucketname: datasource.s3config!.bucketname!,
                                endpoint: datasource.s3config!.endpoint!,
                                sessionToken: datasource.s3config!.sessionToken,
                                sessionkey: datasource.s3config!.sessionKey!),
                          );
                        });
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: const Icon(
                    Icons.change_circle,
                    color: Colors.green,
                  ),
                  onTap: () {
                    showGeneralDialog(
                        barrierDismissible: true,
                        barrierLabel: "modify",
                        context: context,
                        pageBuilder: (c, _, __) {
                          return Center(
                            child:
                                ModifyDatasourceDialog(datasource: datasource),
                          );
                        });
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {
                    ref
                        .read(datasourceProvider.notifier)
                        .removeDatasource(datasource);
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text: "endpoint: ",
                  style: TextStyle(color: AppStyle.appColor)),
              TextSpan(text: datasource.s3config!.endpoint),
            ])),
            const SizedBox(
              height: 10,
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text: "bucketname: ",
                  style: TextStyle(color: AppStyle.appColor)),
              TextSpan(text: datasource.s3config!.bucketname),
            ])),
            const SizedBox(
              height: 10,
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text: "accesskey: ",
                  style: TextStyle(color: AppStyle.appColor)),
              TextSpan(
                  text: datasource.s3config!.accesskey!
                      .replaceRange(3, null, "***")),
            ])),
            const SizedBox(
              height: 10,
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text: "sessionKey: ",
                  style: TextStyle(color: AppStyle.appColor)),
              TextSpan(
                  text: datasource.s3config!.sessionKey!
                      .replaceRange(3, null, "***")),
            ])),
            const SizedBox(
              height: 10,
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text: "sessionToken: ",
                  style: TextStyle(color: AppStyle.appColor)),
              if (datasource.s3config!.sessionToken == null ||
                  datasource.s3config!.sessionToken == "")
                const TextSpan(
                    text: "(It is better to have a session token)",
                    style: TextStyle(color: Colors.amberAccent)),
              if (datasource.s3config!.sessionToken != null &&
                  datasource.s3config!.sessionToken != "" &&
                  datasource.s3config!.sessionToken!.length > 5)
                TextSpan(
                    text: datasource.s3config!.sessionToken!
                        .replaceRange(3, null, "***")),
            ])),
            const SizedBox(
              height: 10,
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text: "region: ", style: TextStyle(color: AppStyle.appColor)),
              TextSpan(text: datasource.s3config!.region),
            ])),
            const SizedBox(
              height: 10,
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text: "type: ", style: TextStyle(color: AppStyle.appColor)),
              TextSpan(text: datasource.datasourceType.toStr()),
            ])),
          ],
        ),
      );
    } else {
      return Container(
        width: 300,
        height: 350,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                offset: const Offset(0, 0),
                blurRadius: 5,
                spreadRadius: 5,
              ),
            ]),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all()),
                  width: 40,
                  height: 40,
                  child: const Center(
                    child: Icon(Icons.storage),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Text(
                  datasource.name ?? "",
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                )),
                const Spacer(),
                InkWell(
                  child: const Icon(
                    Icons.preview,
                    color: Colors.blue,
                  ),
                  onTap: () {},
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {
                    ref
                        .read(datasourceProvider.notifier)
                        .removeDatasource(datasource);
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text: "name: ", style: TextStyle(color: AppStyle.appColor)),
              TextSpan(text: datasource.name),
            ])),
          ],
        ),
      );
    }
  }
}
