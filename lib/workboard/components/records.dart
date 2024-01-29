import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:date_format/date_format.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:easy_crypt/datasource/notifiers/datasource_notifier.dart';
import 'package:easy_crypt/src/rust/api/crypt.dart' as crypt;
import 'package:easy_crypt/src/rust/api/s3.dart' as s3;
import 'package:easy_crypt/common/clipboard_utils.dart';
import 'package:easy_crypt/common/dev_utils.dart';
import 'package:easy_crypt/common/replace_name.dart';
import 'package:easy_crypt/gen/strings.g.dart';
import 'package:easy_crypt/isar/transfer_records.dart';
import 'package:easy_crypt/layout/notifiers/setting_notifier.dart';
import 'package:easy_crypt/process/process.dart';
import 'package:easy_crypt/src/rust/process/encrypt.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:easy_crypt/workboard/components/multiple_files_dialog.dart';
import 'package:easy_crypt/workboard/models/decrypt_param_dialog_model.dart';
import 'package:easy_crypt/workboard/notifiers/records_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:open_file/open_file.dart';
import 'package:super_clipboard/super_clipboard.dart';

import '../models/records_state.dart';
import 'decrypt_param_dialog.dart';

class RecordsWidget extends ConsumerStatefulWidget {
  const RecordsWidget({super.key});

  @override
  ConsumerState<RecordsWidget> createState() => _EncryptRecordsWidgetState();
}

class _EncryptRecordsWidgetState extends ConsumerState<RecordsWidget> {
  final clipboard = SystemClipboard.instance;

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(settingsNotifier);
    final encrypts = ref.watch(recordsProvider);
    return DropTarget(onDragDone: (details) {
      if (details.files.isNotEmpty) {
        if (details.files.length == 1) {
          ref
              .read(recordsProvider.notifier)
              .newRecords(details.files, useDefaultKey: false);
        } else {
          /// TODO complete this logic
          showGeneralDialog(
              context: context,
              barrierColor: Colors.transparent,
              barrierLabel: "multi",
              barrierDismissible: true,
              pageBuilder: (c, _, __) {
                return Center(
                  child: MultipleFilesDialog(files: details.files),
                );
              });
        }
      }
    }, child: Builder(builder: (c) {
      return switch (encrypts) {
        AsyncValue<RecordsState>(:final value?) => _buildTable(value),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      };
    }));
  }

  Widget _buildTable(RecordsState value) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Expanded(
              child: DataTable2(
                  empty: Center(
                    child: SizedBox(
                      width: 300,
                      child: Image.asset(
                        "assets/images/nodata.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  columns: _getColumns(),
                  rows: value.list
                      .mapIndexed((i, e) => _buildRow(e, i))
                      .toList())),
          SizedBox(
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: value.pageId == 1
                          ? null
                          : () {
                              ref.read(recordsProvider.notifier).prevPage();
                            },
                      child: Text(t.encryption.table.prev)),
                  TextButton(
                      onPressed: () {
                        ref.read(recordsProvider.notifier).nextPage();
                      },
                      child: Text(t.encryption.table.next)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  DataRow2 _buildRow(Record f, int index) {
    final s3Accounts = ref.read(datasourceProvider.notifier).getS3();

    return DataRow2(
        decoration: BoxDecoration(
          border: const Border(top: BorderSide(color: Colors.grey, width: 1)),
          gradient: f.status == ProgressStatus.onProgress
              ? LinearGradient(
                  stops: [0, f.progress, 1],
                  colors: [Colors.white, AppStyle.progressColor, Colors.white],
                )
              : null,
        ),
        cells: [
          DataCell(Text(f.id.toString())),
          DataCell(f.isEncrypt
              ? const Icon(Icons.lock)
              : const Icon(Icons.lock_open)),
          DataCell(Tooltip(
            message: f.filePath.toString(),
            child: Row(
              children: [
                FileSystemEntity.isFileSync(f.filePath!)
                    ? Image.asset(
                        "assets/icons/File.png",
                        width: AppStyle.rowImageSize,
                        height: AppStyle.rowImageSize,
                        fit: BoxFit.fitWidth,
                      )
                    : Image.asset(
                        "assets/icons/Folder.png",
                        width: AppStyle.rowImageSize,
                        height: AppStyle.rowImageSize,
                        fit: BoxFit.fitWidth,
                      ),
                Expanded(
                    child: Text(
                  f.filePath.toString(),
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ))
              ],
            ),
          )),
          DataCell(
            f.status == ProgressStatus.unstart ||
                    f.status == ProgressStatus.done
                ? Row(
                    children: [
                      if (f.savePath != null)
                        Image.asset(
                          "assets/icons/enf.png",
                          width: AppStyle.rowImageSize - 5,
                          height: AppStyle.rowImageSize - 5,
                          fit: BoxFit.fitWidth,
                        ),
                      Expanded(
                          child: Tooltip(
                              message: f.savePath == null
                                  ? ""
                                  : f.savePath.toString(),
                              child: Text(
                                f.savePath ?? "",
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ))),
                      if (f.savePath != null)
                        InkWell(
                          onTap: () async {
                            if (clipboard == null) {
                              return;
                            }
                            final item = DataWriterItem();
                            item.add(Formats.fileUri(
                                Uri.file(f.savePath.toString())));
                            await clipboard!.write([item]);
                          },
                          child: Tooltip(
                            message: t.encryption.table.cpfilepath,
                            child: const Icon(
                              Icons.copy_all,
                              size: AppStyle.rowIconSize,
                            ),
                          ),
                        ),
                      if (f.savePath != null)
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SizedBox(
                            child: ContextMenuRegion(
                                contextMenu: ContextMenu(
                                  entries: [
                                    MenuItem.submenu(
                                      label: t.encryption.table.upto,
                                      icon: const Icon(
                                        Icons.upload,
                                        size: AppStyle.rowIconSize,
                                      ),
                                      items: [
                                        if (s3Accounts.isEmpty)
                                          const MenuItem(
                                            icon: Icon(
                                              Icons.storage,
                                              size: AppStyle.rowIconSize,
                                            ),
                                            label: "S3",
                                            value: "S3",
                                          ),
                                        if (s3Accounts.isNotEmpty)
                                          MenuItem.submenu(
                                              icon: const Icon(
                                                Icons.storage,
                                                size: AppStyle.rowIconSize,
                                              ),
                                              label: "S3",
                                              items: s3Accounts
                                                  .map((e) => MenuItem(
                                                        label: e.name ?? "",
                                                        value: e.name ?? "",
                                                        onSelected: () {
                                                          IsolateProcess.upload(
                                                              e,
                                                              f.savePath!,
                                                              replacePath(
                                                                  f.savePath!),
                                                              f.id,
                                                              ref: ref);
                                                        },
                                                      ))
                                                  .toList()),
                                      ],
                                    ),
                                    MenuItem.submenu(
                                      label: t.encryption.table.shareto,
                                      icon: const Icon(
                                        Icons.share,
                                        size: AppStyle.rowIconSize,
                                      ),
                                      items: [
                                        MenuItem(
                                          icon: const Icon(
                                            Icons.wechat,
                                            size: AppStyle.rowIconSize,
                                          ),
                                          label: t.encryption.table.wx,
                                          value: "Wechat",
                                        ),
                                        if (f.transferRecords.isNotEmpty)
                                          MenuItem.submenu(
                                              icon: const Icon(
                                                Icons.storage,
                                                size: AppStyle.rowIconSize,
                                              ),
                                              label: "by url",
                                              items: f.transferRecords
                                                  .map((e) => MenuItem(
                                                      onSelected: () async {
                                                        // print(e.to);
                                                        if (e.toType ==
                                                            StorageType.S3) {
                                                          final url = await s3.generatePregisnUrl(
                                                              endpoint: e
                                                                  .toDatasource
                                                                  .value!
                                                                  .endpoint!,
                                                              bucketname: e
                                                                  .toDatasource
                                                                  .value!
                                                                  .bucketname!,
                                                              accessKey: e
                                                                  .toDatasource
                                                                  .value!
                                                                  .accesskey!,
                                                              sessionKey: e
                                                                  .toDatasource
                                                                  .value!
                                                                  .sessionKey!,
                                                              region: e
                                                                  .toDatasource
                                                                  .value!
                                                                  .region!,
                                                              sessionToken: e
                                                                  .toDatasource
                                                                  .value!
                                                                  .sessionToken!,
                                                              obj: e.to!);
                                                          if (url != null) {
                                                            await copyToClipboard(
                                                                url);
                                                          }
                                                        }
                                                      },
                                                      label: e.toDatasource
                                                                  .value !=
                                                              null
                                                          ? e
                                                                  .toDatasource
                                                                  .value!
                                                                  .name ??
                                                              "1"
                                                          : "2"))
                                                  .toList()),
                                      ],
                                    ),
                                    MenuItem(
                                      label: t.encryption.table.openfolder,
                                      value: "Open folder",
                                      icon: const Icon(
                                        Icons.open_in_new,
                                        size: AppStyle.rowIconSize,
                                      ),
                                      onSelected: () {
                                        final d = File(f.savePath!).parent.path;
                                        OpenFile.open(d);
                                      },
                                    ),
                                    MenuItem(
                                      label: t.encryption.table.rmfile,
                                      value: "Remove file",
                                      icon: const Icon(
                                        Icons.delete,
                                        size: AppStyle.rowIconSize,
                                      ),
                                      onSelected: () {
                                        ref
                                            .read(recordsProvider.notifier)
                                            .removeFile(f);
                                      },
                                    )
                                  ],
                                ),
                                child: Transform.rotate(
                                  angle: 3.14 / 2,
                                  child: const Icon(
                                    Icons.arrow_right,
                                    size: AppStyle.rowIconSize,
                                    color: Colors.black,
                                  ),
                                )),
                          ),
                        )
                    ],
                  )
                : Text("${(f.progress * 100).ceil()}%"),
          ),
          DataCell(!f.isEncrypt
              ? Row(
                  children: [
                    Expanded(
                        child: Text(
                      f.key.toString(),
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    )),
                    if (f.key != null)
                      InkWell(
                        onTap: () async {
                          await copyToClipboard(f.key ?? "");
                        },
                        child: Tooltip(
                          message: t.encryption.table.cpkey,
                          child: const Icon(
                            Icons.copy,
                            size: AppStyle.rowIconSize,
                          ),
                        ),
                      )
                  ],
                )
              : Text(
                  f.key.toString(),
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                )),
          DataCell(Text(formatDate(
              DateTime.fromMillisecondsSinceEpoch(f.createAt),
              [yyyy, "-", mm, "-", dd]))),
          DataCell(Row(
            children: [
              InkWell(
                onTap: () async {
                  if (!f.isEncrypt) {
                    /// TODO use isolate
                    crypt
                        .encrypt(
                            saveDir: DevUtils.cachePath,
                            files: [
                              EncryptItem(filePath: f.filePath!, fileId: f.id)
                            ],
                            key: f.key!)
                        .then((value) {
                      ref
                          .read(recordsProvider.notifier)
                          .changeProgress(f.id, 1, saved: value);
                    });
                  } else {
                    DecryptParamDialogModel? r = await showGeneralDialog(
                        barrierDismissible: true,
                        barrierLabel: "decrypt dialog",
                        context: context,
                        pageBuilder: (c, _, __) {
                          return Center(
                            child: DecryptParamDialog(
                              needsKey: f.key == null,
                            ),
                          );
                        });

                    if (r != null) {
                      crypt
                          .decrypt(
                              saveDir: DevUtils.cachePath,
                              path: f.filePath!,
                              fileType: r.fileType,
                              fileId: f.id,
                              key: f.key != null ? f.key! : r.key)
                          .then((value) {
                        ref
                            .read(recordsProvider.notifier)
                            .changeProgress(f.id, 1, saved: value);
                      });

                      if (r.saveKey) {
                        ref.read(recordsProvider.notifier).setKey(f.id, r.key);
                      }
                    }
                  }
                },
                child: Tooltip(
                  message: t.encryption.table.startencrypt,
                  child: const Icon(
                    Icons.play_arrow,
                    size: AppStyle.rowIconSize,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  ref.read(recordsProvider.notifier).removeRecord(f);
                },
                child: Tooltip(
                  message: t.encryption.table.rmrecord,
                  child: const Icon(
                    Icons.delete,
                    size: AppStyle.rowIconSize,
                  ),
                ),
              ),
            ],
          )),
        ]);
  }

  List<DataColumn2> _getColumns() {
    return [
      DataColumn2(
        fixedWidth: 60,
        label: Text(
          t.encryption.column.no,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
      const DataColumn2(
        fixedWidth: 90,
        label: Text(
          "type",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
      DataColumn2(
        label: Text(
          t.encryption.column.filepath,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
      DataColumn2(
        label: Text(
          t.encryption.column.encryptedPath,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
      DataColumn2(
        fixedWidth: 130,
        label: Text(
          t.encryption.column.key,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
      DataColumn2(
        fixedWidth: 140,
        label: Text(
          t.encryption.column.createAt,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
      DataColumn2(
        fixedWidth: 120,
        label: Text(
          t.encryption.column.operation,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
    ];
  }
}
