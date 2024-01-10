import 'package:data_table_2/data_table_2.dart';
import 'package:date_format/date_format.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:easy_crypt/bridge/native.dart';
import 'package:easy_crypt/common/clipboard_utils.dart';
import 'package:easy_crypt/common/dev_utils.dart';
import 'package:easy_crypt/workboard/notifiers/encrypt_records_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import '../models/encrypt_records_state.dart';

class EncryptRecordsWidget extends ConsumerStatefulWidget {
  const EncryptRecordsWidget({super.key});

  @override
  ConsumerState<EncryptRecordsWidget> createState() =>
      _EncryptRecordsWidgetState();
}

class _EncryptRecordsWidgetState extends ConsumerState<EncryptRecordsWidget> {
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
      DataCell(Tooltip(
        message: f.savePath.toString(),
        child:
            f.status == EncryptStatus.unstart || f.status == EncryptStatus.done
                ? Text(
                    f.savePath.toString(),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  )
                : LinearProgressIndicator(
                    value: f.progress,
                  ),
      )),
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
              child: const Icon(
                Icons.copy,
                size: 15,
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
                  files: [f.filePath!],
                  key: f.key!)
              .then((value) {
            ref
                .read(encryptRecordsProvider.notifier)
                .changeProgress(f.filePath!, 1, saved: value);
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
