import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/compress_notifier.dart';

class CompressFilesBox extends ConsumerWidget {
  const CompressFilesBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(compressProvider);

    return Visibility(
        visible: data.jobs.isNotEmpty,
        child: Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          width: 300,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  offset: const Offset(0, 0),
                  blurRadius: 3,
                  spreadRadius: 3,
                ),
              ]),
        ));
  }
}
