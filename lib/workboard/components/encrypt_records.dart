import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:date_format/date_format.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:easy_crypt/account/notifiers/account_notifier.dart';
import 'package:easy_crypt/bridge/native.dart';
import 'package:easy_crypt/common/clipboard_utils.dart';
import 'package:easy_crypt/common/dev_utils.dart';
import 'package:easy_crypt/common/replace_name.dart';
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
                      child: const Text("上一页")),
                  TextButton(
                      onPressed: () {
                        ref.read(encryptRecordsProvider.notifier).nextPage();
                      },
                      child: const Text("下一页")),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  DataRow2 _buildRow(EncryptRecord f, int index) {
    print("f.transferLogs.isEmpty    ${f.transferLogs.isEmpty}");
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
                          child: const Tooltip(
                            message: "Copy file path",
                            child: Icon(
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
                                      label: "Upload to",
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
                                                              ref: ref);
                                                        },
                                                      ))
                                                  .toList()),
                                      ],
                                    ),
                                    MenuItem.submenu(
                                      label: "Share to",
                                      icon: const Icon(
                                        Icons.share,
                                        size: AppStyle.rowIconSize,
                                      ),
                                      items: [
                                        const MenuItem(
                                          icon: Icon(
                                            Icons.wechat,
                                            size: AppStyle.rowIconSize,
                                          ),
                                          label: "Wechat",
                                          value: "Wechat",
                                        ),
                                        if (f.transferLogs.isNotEmpty)
                                          MenuItem.submenu(
                                              icon: const Icon(
                                                Icons.storage,
                                                size: AppStyle.rowIconSize,
                                              ),
                                              label: "storages",
                                              items: f.transferLogs
                                                  .map((e) => MenuItem(
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
                                      label: "Open folder",
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
                                      label: "Remove file",
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
                  child: const Tooltip(
                    message: "Copy Key",
                    child: Icon(
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
                child: const Tooltip(
                  message: "Start encrypt",
                  child: Icon(
                    Icons.play_arrow,
                    size: AppStyle.rowIconSize,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  ref.read(encryptRecordsProvider.notifier).removeLog(f);
                },
                child: const Tooltip(
                  message: "Remove record",
                  child: Icon(
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
      const DataColumn2(
        fixedWidth: 60,
        label: Text(
          '编号',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
      const DataColumn2(
        label: Text(
          '文件路径',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
      const DataColumn2(
        label: Text(
          '加密路径',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
      const DataColumn2(
        fixedWidth: 120,
        label: Text(
          '密钥',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
      const DataColumn2(
        fixedWidth: 140,
        label: Text(
          '创建时间',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
      const DataColumn2(
        fixedWidth: 80,
        label: Text(
          '操作',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
    ];
  }
}
