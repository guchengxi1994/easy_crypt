import 'dart:isolate';

import 'package:easy_crypt/bridge/native.dart';
import 'package:easy_crypt/common/dev_utils.dart';
import 'package:easy_crypt/common/logger.dart';

class Message {
  final SendPort? sendPort;
  final List<String> paths;
  final String key;

  Message({this.sendPort, required this.key, required this.paths});
}

class CryptProcess {
  CryptProcess._();

  static void encrypt(List<String> paths, String key) async {
    ReceivePort receivePort = ReceivePort();
    receivePort.listen((message) {
      logger.info(message);
    });
    Isolate.spawn<Message>((message) {
      _execEncrypt(message);
    }, Message(sendPort: receivePort.sendPort, key: key, paths: paths));
  }

  static void _execEncrypt(Message message) async {
    logger.info("new isolate start");
    final s = await api.encrypt(
        saveDir: DevUtils.cachePath, files: message.paths, key: message.key);
    logger.info("new isolate finish");
    message.sendPort?.send(s);
  }
}
