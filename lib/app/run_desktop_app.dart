import 'dart:ui';

import 'package:easy_crypt/layout/desktop_layout.dart';
import 'package:easy_crypt/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

void runAPP() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.setTitleBarStyle(TitleBarStyle.hidden);
  windowManager.waitUntilReadyToShow(null, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setMinimumSize(const Size(1280, 720));
    await windowManager.setHasShadow(true);
  });
  windowManager.setBackgroundColor(Colors.transparent);
  runApp(ProviderScope(
    child: MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      theme: ThemeData(
        fontFamily: "NotoSns",
        colorScheme: ColorScheme.fromSeed(seedColor: AppStyle.appColor),
        useMaterial3: true,
        tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
      ),
      debugShowCheckedModeBanner: false,
      home: const Layout(),
    ),
  ));
}
