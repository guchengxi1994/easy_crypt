// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:io';

import 'package:easy_crypt/common/dev_utils.dart';
import 'package:easy_crypt/common/local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'app/run_desktop_app.dart';
import 'isar/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });

  final IsarDatabase database = IsarDatabase();
  await database.initialDatabase();
  final _ = LocalStorage();

  if (!Directory(DevUtils.cachePath).existsSync()) {
    Directory(DevUtils.cachePath).createSync();
  }

  runAPP();
}
