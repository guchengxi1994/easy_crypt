// ignore_for_file: avoid_init_to_null

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_crypt/file_system/models/datasource_state.dart';
import 'package:easy_crypt/file_system/notifiers/datasource_notifier.dart';
import 'package:easy_crypt/isar/datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef OnItemSelect = void Function(dynamic);

class DatasourceSelection extends ConsumerStatefulWidget {
  const DatasourceSelection({super.key, required this.onItemSelect});
  final OnItemSelect onItemSelect;

  @override
  ConsumerState createState() => _DatasourceSelectionState();
}

class _DatasourceSelectionState extends ConsumerState<DatasourceSelection> {
  late Datasource? selectedValue = null;

  @override
  Widget build(BuildContext context) {
    final datasources = ref.watch(datasourceItemsProvider);

    return Builder(builder: (c) {
      return switch (datasources) {
        AsyncValue<DatasourceState>(:final value?) =>
          DropdownButtonHideUnderline(
              child: DropdownButton2<Datasource>(
            isExpanded: true,
            hint: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            customButton: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4)),
              width: 240,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Text("${selectedValue?.name.toString()}")),
                  const Icon(Icons.arrow_downward, size: 20, color: Colors.grey)
                ],
              ),
            ),

            /// TODO 将创建本地datasource 放到下拉菜单中
            items: value.datasources
                .map((item) => DropdownMenuItem<Datasource>(
                      value: item,
                      child: Text(
                        item.name.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (v) {
              setState(() {
                selectedValue = v;
              });
              widget.onItemSelect(v);
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 140,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          )),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      };
    });
  }
}
