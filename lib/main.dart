// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:isolate';

import 'package:easy_crypt/bridge/native.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'app/run_desktop_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  runAPP();
}

class Message {
  final SendPort? sendPort;

  Message({this.sendPort});
}

run() async {
  ReceivePort receivePort = ReceivePort();
  receivePort.listen((message) {
    print(message);
  });

  Isolate.spawn<Message>((message) {
    exec(message);
  }, Message(sendPort: receivePort.sendPort));
}

void exec(Message message) async {
  print("new isolate doWork start");
  await Future.delayed(const Duration(seconds: 5)).then(
    (value) async {
      await api.testEncrypt();
    },
  );
  print("new isolate doWork end");
  // return "complete";
  message.sendPort?.send("complete");
}
