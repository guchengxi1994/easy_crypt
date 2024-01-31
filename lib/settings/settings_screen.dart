import 'package:easy_crypt/common/clipboard_utils.dart';
import 'package:easy_crypt/isar/settings.dart';
import 'package:easy_crypt/settings/settings_notifier.dart';
import 'package:easy_crypt/src/rust/api/crypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settingsProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      child: _build(state),
    );
  }

  Widget _build(Settings? settings) {
    return Column(
      children: [_wrapper("Default key", _keyGenerator(settings))],
    );
  }

  _wrapper(String title, Widget child) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(title),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.centerLeft,
          child: child,
        ))
      ],
    );
  }

  bool reGenerate = false;
  String generated = "";

  Widget _keyGenerator(Settings? settings) {
    return Row(
      children: [
        Container(
          // width: 300,
          constraints: const BoxConstraints(maxWidth: 300, minWidth: 100),
          child: generated != ""
              ? Text(generated)
              : settings == null || settings.key == null
                  ? const Text(
                      "key unset",
                      style: TextStyle(color: Colors.red),
                    )
                  : Text(
                      settings.key!
                          .replaceRange(5, settings.key!.length, "*****"),
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: settings == null || settings.key == null
              ? null
              : () {
                  ClipboardUtils.copyText(settings.key!);
                },
          child: const Icon(Icons.copy),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () async {
            generated = await randomKey();

            setState(() {
              reGenerate = true;
            });
          },
          child: const Icon(Icons.refresh),
        ),
        const SizedBox(
          width: 10,
        ),
        if (reGenerate)
          InkWell(
            onTap: () {
              ref.read(settingsProvider.notifier).newSettings(key: generated);
              setState(() {
                reGenerate = false;
                generated = "";
              });
            },
            child: const Icon(
              Icons.check,
              color: Colors.green,
            ),
          ),
        const SizedBox(
          width: 10,
        ),
        if (reGenerate)
          InkWell(
            onTap: () {
              setState(() {
                reGenerate = false;
                generated = "";
              });
            },
            child: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}
