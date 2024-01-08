import 'package:easy_crypt/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

class Layout extends ConsumerStatefulWidget {
  const Layout({super.key});

  @override
  ConsumerState<Layout> createState() => _LayoutState();
}

class _LayoutState extends ConsumerState<Layout> {
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
        ));
  }
}
