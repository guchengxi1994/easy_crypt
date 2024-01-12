import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:date_format/date_format.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_crypt/bridge/native.dart';
import 'package:easy_crypt/common/clipboard_utils.dart';
import 'package:easy_crypt/common/dev_utils.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:easy_crypt/workboard/notifiers/encrypt_records_notifier.dart';
import 'package:flutter/material.dart';
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
        ref
            .read(encryptRecordsProvider.notifier)
            .newRecords(details.files, useDefaultKey: false);
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
          rows: value.list.mapIndexed((i, e) => _buildRow(e, i)).toList()),
    );
  }

  DataRow2 _buildRow(EncryptRecord f, int index) {
    return DataRow2(cells: [
      DataCell(Text(f.id.toString())),
      DataCell(Tooltip(
        message: f.filePath.toString(),
        child: Text(
          f.filePath.toString(),
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      DataCell(
        f.status == EncryptStatus.unstart || f.status == EncryptStatus.done
            ? Row(
                children: [
                  Expanded(
                      child: Tooltip(
                          message:
                              f.savePath == null ? "" : f.savePath.toString(),
                          child: Text(
                            f.savePath.toString(),
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
                        item.add(
                            Formats.fileUri(Uri.file(f.savePath.toString())));
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
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        customButton: Transform.rotate(
                          angle: 3.14 / 2,
                          child: const Icon(
                            Icons.arrow_right,
                            size: AppStyle.rowIconSize,
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (value) {
                          // print(value);
                        },
                        dropdownStyleData: DropdownStyleData(
                          width: 250,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          offset: const Offset(0, 8),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.only(left: 16, right: 16),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 1,
                            onTap: () async {
                              final d = File(f.savePath!).parent.path;

                              OpenFile.open(d);
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.open_in_browser),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Open folder")
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            onTap: () async {
                              ref
                                  .read(encryptRecordsProvider.notifier)
                                  .removeEncryptedFile(f);
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.delete),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Remove file")
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              )
            : LinearProgressIndicator(
                value: f.progress,
              ),
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
      DataCell(Text(formatDate(DateTime.fromMillisecondsSinceEpoch(f.createAt),
          [yyyy, "-", mm, "-", dd]))),
      DataCell(InkWell(
        onTap: () {
          api
              .encrypt(
                  saveDir: DevUtils.cachePath,
                  files: [EncryptItem(filePath: f.filePath!, fileId: f.id)],
                  key: f.key!)
              .then((value) {
            ref
                .read(encryptRecordsProvider.notifier)
                .changeProgress(f.id, 1, saved: value);
          });
        },
        child: const Text(
          "详情",
          style: TextStyle(color: Colors.blue),
        ),
      )),
    ]);
  }

  List<DataColumn2> _getColumns() {
    return [
      const DataColumn2(
        fixedWidth: 80,
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
