import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:date_format/date_format.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:easy_crypt/account/notifiers/account_notifier.dart';
import 'package:easy_crypt/bridge/native.dart';
import 'package:easy_crypt/common/clipboard_utils.dart';
import 'package:easy_crypt/common/dev_utils.dart';
import 'package:easy_crypt/common/replace_name.dart';
import 'package:easy_crypt/gen/strings.g.dart';
import 'package:easy_crypt/isar/transfer_records.dart';
import 'package:easy_crypt/layout/notifiers/setting_notifier.dart';
import 'package:easy_crypt/process/process.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:easy_crypt/workboard/components/multiple_files_dialog.dart';
import 'package:easy_crypt/workboard/notifiers/encrypt_records_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:open_file/open_file.dart';
import 'package:super_clipboard/super_clipboard.dart';

import '../models/encrypt_records_state.dart';

class EncryptRecordsWidget extends ConsumerStatefulWidget {
  const EncryptRecordsWidget({super.key});

  @override
  ConsumerState<EncryptRecordsWidget> createState() =>
      _EncryptRecordsWidgetState();
}

class _EncryptRecordsWidgetState extends ConsumerState<EncryptRecordsWidget> {
  final clipboard = SystemClipboard.instance;

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(settingsNotifier);
    final encrypts = ref.watch(encryptRecordsProvider);
    return DropTarget(onDragDone: (details) {
      if (details.files.isNotEmpty) {
        if (details.files.length == 1) {
          ref
              .read(encryptRecordsProvider.notifier)
              .newRecords(details.files, useDefaultKey: false);
        } else {
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
        AsyncValue<EncryptRecordsState>(:final value?) => _buildTable(value),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      };
    }));
  }

  Widget _buildTable(EncryptRecordsState value) {
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
                              ref
                                  .read(encryptRecordsProvider.notifier)
                                  .prevPage();
                            },
                      child: Text(t.encryption.table.prev)),
                  TextButton(
                      onPressed: () {
                        ref.read(encryptRecordsProvider.notifier).nextPage();
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

  DataRow2 _buildRow(EncryptRecord f, int index) {
    final s3Accounts = ref.read(accountProvider.notifier).getS3();

    return DataRow2(
        decoration: BoxDecoration(
          border: const Border(top: BorderSide(color: Colors.grey, width: 1)),
          gradient: f.status == EncryptStatus.onProgress
              ? LinearGradient(
                  stops: [0, f.progress, 1],
                  colors: [Colors.white, AppStyle.progressColor, Colors.white],
                )
              : null,
        ),
        cells: [
          DataCell(Text(f.id.toString())),
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
            f.status == EncryptStatus.unstart || f.status == EncryptStatus.done
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
                                                          final url = await api
                                                              .generatePregisnUrl(
                                                                  endpoint: e
                                                                      .account
                                                                      .value!
                                                                      .endpoint!,
                                                                  bucketname: e
                                                                      .account
                                                                      .value!
                                                                      .bucketname!,
                                                                  accessKey: e
                                                                      .account
                                                                      .value!
                                                                      .accesskey!,
                                                                  sessionKey: e
                                                                      .account
                                                                      .value!
                                                                      .sessionKey!,
                                                                  region: e
                                                                      .account
                                                                      .value!
                                                                      .region!,
                                                                  sessionToken: e
                                                                      .account
                                                                      .value!
                                                                      .sessionToken!,
                                                                  obj: e.to!);
                                                          if (url != null) {
                                                            await copyToClipboard(
                                                                url);
                                                          }
                                                        }
                                                      },
                                                      label: e.account.value !=
                                                              null
                                                          ? e.account.value!
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
                                            .read(
                                                encryptRecordsProvider.notifier)
                                            .removeEncryptedFile(f);
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
          DataCell(Row(
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
          )),
          DataCell(Text(formatDate(
              DateTime.fromMillisecondsSinceEpoch(f.createAt),
              [yyyy, "-", mm, "-", dd]))),
          DataCell(Row(
            children: [
              InkWell(
                onTap: () {
                  /// TODO use isolate
                  api
                      .encrypt(
                          saveDir: DevUtils.cachePath,
                          files: [
                            EncryptItem(filePath: f.filePath!, fileId: f.id)
                          ],
                          key: f.key!)
                      .then((value) {
                    ref
                        .read(encryptRecordsProvider.notifier)
                        .changeProgress(f.id, 1, saved: value);
                  });
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
                  ref.read(encryptRecordsProvider.notifier).removeLog(f);
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
