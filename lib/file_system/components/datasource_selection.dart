// ignore_for_file: avoid_init_to_null

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_crypt/datasource/models/datasource_state.dart';
import 'package:easy_crypt/datasource/notifiers/datasource_notifier.dart';

import 'package:easy_crypt/gen/strings.g.dart';
import 'package:easy_crypt/isar/datasource.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef OnItemSelect = void Function(Datasource ds);

class DatasourceSelection extends ConsumerStatefulWidget {
  const DatasourceSelection({super.key, required this.onItemSelect});
  final OnItemSelect onItemSelect;

  @override
  ConsumerState createState() => _DatasourceSelectionState();
}

class _DatasourceSelectionState extends ConsumerState<DatasourceSelection> {
  late Datasource? selectedValue = null;

  List<Datasource> items = [];
  bool _isOpen = false;

  late LocalConfig newLocalConfig = LocalConfig()..path = "selecting";

  @override
  Widget build(BuildContext context) {
    final datasources = ref.watch(datasourceProvider);

    return switch (datasources) {
      AsyncValue<DatasourceState>(:final value?) => Builder(builder: (c) {
          items = List.of(value.datasources)
            ..add(Datasource()
              ..datasourceType = DatasourceType.Local
              ..name = t.workboard.addlocal
              ..localConfig = newLocalConfig);

          return DropdownButtonHideUnderline(
              child: DropdownButton2<Datasource>(
            isExpanded: false,
            hint: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            onMenuStateChange: (isOpen) {
              setState(() {
                _isOpen = isOpen;
              });
            },
            customButton: AnimatedContainer(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4)),
              width: _isOpen ? 240 : 100,
              duration: const Duration(milliseconds: 150),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    selectedValue == null
                        ? ""
                        : "${selectedValue?.name.toString()}",
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                  )),
                  const Icon(Icons.arrow_downward, size: 20, color: Colors.grey)
                ],
              ),
            ),
            items: items
                .map((item) => DropdownMenuItem<Datasource>(
                      value: item,
                      child: SizedBox(
                        width: 240,
                        child: Text.rich(
                          TextSpan(children: [
                            if (item.localConfig?.path != "selecting")
                              TextSpan(
                                text: "[${item.datasourceType.name}]  ",
                                style: const TextStyle(
                                    fontSize: 14, color: AppStyle.appColor),
                              ),
                            TextSpan(
                              text: item.name.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            )
                          ]),
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (v) {
              if (v != null) {
                widget.onItemSelect(v);

                setState(() {
                  selectedValue = v;
                });
              }
            },
            dropdownStyleData: DropdownStyleData(
              width: 240,
              offset: const Offset(-140, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ));
        }),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}
