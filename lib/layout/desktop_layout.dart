import 'dart:convert';

import 'package:easy_crypt/bridge/native.dart';
import 'package:easy_crypt/common/logger.dart';
import 'package:easy_crypt/customize_flow/flow_screen.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:easy_crypt/workboard/notifiers/encrypt_records_notifier.dart';
import 'package:easy_crypt/workboard/workboard.dart';
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
    // print("stream.isBroadcast  ${stream.isBroadcast}");   // ----> false <----
    stream.listen((event) {
      logger.info(event);
      final j = jsonDecode(event);
      if (j["type"] == 2) {
        ref.read(encryptRecordsProvider.notifier).changeProgress(
            j["unique_id"], j["encrypt_size"] / j["total_size"]);
      } else if (j["type"] == 3) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppStyle.appbarHeight),
        child: WindowCaption(
          brightness: Brightness.light,
          backgroundColor: AppStyle.appColor,
          title: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
              ),
            ],
          ),
        ),
      ),
      // body: const Workboard(),
      body: const FlowScreen(),
    );
  }
}
