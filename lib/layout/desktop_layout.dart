import 'package:easy_crypt/bridge/native.dart';
import 'package:easy_crypt/common/logger.dart';
import 'package:easy_crypt/process/process.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

class Layout extends ConsumerStatefulWidget {
  const Layout({super.key});

  @override
  ConsumerState<Layout> createState() => _LayoutState();
}

class _LayoutState extends ConsumerState<Layout> {
  final stream = api.nativeMessageStream();

  @override
  void initState() {
    super.initState();
    stream.listen((event) {
      logger.info(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppStyle.appbarHeight),
        child: WindowCaption(
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: TextButton(
            onPressed: () async {
              final XFile? file = await openFile();
              if (file != null) {
                CryptProcess.encrypt([file.path], await api.randomKey());
              }
            },
            child: const Text("test encrypt")),
      ),
    );
  }
}
