import 'dart:io';

import 'package:flutter/material.dart';

class DevUtils {
  static Directory get executableDir =>
      File(Platform.resolvedExecutable).parent;
  static String cachePath = "${DevUtils.executableDir.path}/cache";

  static GlobalKey<State<NavigationRail>> navigationKey = GlobalKey();
}
