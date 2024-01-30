import 'package:data_table_2/data_table_2.dart';
import 'package:date_format/date_format.dart';
import 'package:easy_crypt/isar/database.dart';
import 'package:easy_crypt/isar/process_records.dart';
import 'package:easy_crypt/gen/strings.g.dart';
import 'package:easy_crypt/layout/notifiers/setting_notifier.dart';
import 'package:easy_crypt/records/notifiers/records_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:super_clipboard/super_clipboard.dart';

import '../models/records_state.dart';

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
    return switch (encrypts) {
      AsyncValue<RecordsState>(:final value?) => _buildTable(value),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
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

  late final IsarDatabase database = IsarDatabase();

  DataRow2 _buildRow(ProcessRecords p, int index) {
    // final s3Accounts = ref.read(datasourceProvider.notifier).getS3();
    String from, to, path, savedTo;
    Object config;
    if (p.jobType == JobType.decrypt) {
      config = p.decryptConfig!;
      from = (config as CryptConfig).getByDatasourceId(database)?.name ?? "";
      to = (config).getByDatasourceId(database)?.name ?? "";
      path = config.path ?? "";
      savedTo = config.savedPath ?? "";
    } else if (p.jobType == JobType.encrypt) {
      config = p.encryptConfig!;
      from = (config as CryptConfig).getByDatasourceId(database)?.name ?? "";
      to = (config).getByDatasourceId(database)?.name ?? "";
      path = config.path ?? "";
      savedTo = config.savedPath ?? "";
    } else {
      config = p.transferConfig!;
      from = (config as TransferConfig).getFrom(database)?.name ?? "";
      to = (config).getTo(database)?.name ?? "";
      path = config.from ?? "";
      savedTo = config.to ?? "";
    }

    return DataRow2(cells: [
      DataCell(Text(p.id.toString())),
      DataCell(p.jobType.toWidget()),
      DataCell(Tooltip(
        message: from,
        waitDuration: const Duration(seconds: 1),
        child: Text(
          from,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      DataCell(Tooltip(
        message: to,
        waitDuration: const Duration(seconds: 1),
        child: Text(
          to,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      DataCell(Tooltip(
        message: path,
        waitDuration: const Duration(seconds: 1),
        child: Text(
          path,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      DataCell(Tooltip(
        message: savedTo,
        waitDuration: const Duration(seconds: 1),
        child: Text(
          savedTo,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      DataCell(Text(formatDate(DateTime.fromMillisecondsSinceEpoch(p.createAt),
          [yyyy, "-", mm, "-", dd]))),
      DataCell(Row(
        children: [
          InkWell(
            onTap: () {},
            child: const Icon(Icons.delete),
          )
        ],
      ))
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
      const DataColumn2(
        fixedWidth: 120,
        label: Text(
          "from",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
      const DataColumn2(
        fixedWidth: 120,
        label: Text(
          "to",
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
        fixedWidth: 140,
        label: Text(
          t.encryption.column.createAt,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
        numeric: false,
      ),
      DataColumn2(
        fixedWidth: 80,
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
