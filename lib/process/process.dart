import 'dart:isolate';

import 'package:easy_crypt/src/rust/api/simple.dart' as api;
import 'package:easy_crypt/common/dev_utils.dart';
import 'package:easy_crypt/common/logger.dart';
import 'package:easy_crypt/isar/account.dart';
import 'package:easy_crypt/isar/database.dart';
import 'package:easy_crypt/isar/files.dart';
import 'package:easy_crypt/isar/transfer_records.dart';
import 'package:easy_crypt/src/rust/frb_generated.dart';
import 'package:easy_crypt/src/rust/process/encrypt.dart';
import 'package:easy_crypt/workboard/notifiers/encrypt_records_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class Message {
  final SendPort? sendPort;
  final List<EncryptItem> paths;
  final String key;

  Message({this.sendPort, required this.key, required this.paths});
}

class UploadMessage {
  final SendPort? sendPort;
  final String endpoint;
  final String bucketname;
  final String accessKey;
  final String sessionKey;
  final String? sessionToken;
  final String region;
  final String p;
  final String objectKey;

  UploadMessage(
      {this.sendPort,
      required this.endpoint,
      required this.accessKey,
      required this.bucketname,
      required this.objectKey,
      required this.p,
      required this.region,
      required this.sessionKey,
      this.sessionToken});
}

class IsolateProcess {
  IsolateProcess._();

  static void encrypt(List<EncryptItem> items, String key) async {
    ReceivePort receivePort = ReceivePort();
    receivePort.listen((message) {
      logger.info(message);
    });
    Isolate.spawn<Message>((message) {
      _execEncrypt(message);
    }, Message(sendPort: receivePort.sendPort, key: key, paths: items));
  }

  static void _execEncrypt(Message message) async {
    logger.info("new isolate start");
    final s = await api.encrypt(
        saveDir: DevUtils.cachePath, files: message.paths, key: message.key);
    logger.info("new isolate finish");
    message.sendPort?.send(s);
  }

  static void upload(
      Account account, final String p, final String objectKey, int fileId,
      {WidgetRef? ref}) async {
    ReceivePort receivePort = ReceivePort();
    receivePort.listen((message) {
      logger.info(message);
      if (message == "ok") {
        final IsarDatabase database = IsarDatabase();
        final file =
            database.isar!.files.filter().idEqualTo(fileId).findFirstSync()!;

        TransferRecords records = TransferRecords()
          ..done = true
          ..fromType = StorageType.Local
          ..toType = account.accountType == AccountType.S3
              ? StorageType.S3
              : StorageType.Webdav
          ..from = p
          ..to = objectKey
          ..account.value = account;
        file.transferRecords.add(records);

        database.isar!.writeTxnSync(() {
          database.isar!.transferRecords.putSync(records);
          records.account.saveSync();
          file.transferRecords.saveSync();
        });

        if (ref != null) {
          ref.read(encryptRecordsProvider.notifier).loadTransferLogs(p);
        }
      }
    });
    Isolate.spawn<UploadMessage>((message) {
      _upload(message);
    },
        UploadMessage(
            sendPort: receivePort.sendPort,
            endpoint: account.endpoint!,
            accessKey: account.accesskey!,
            bucketname: account.bucketname!,
            objectKey: objectKey,
            p: p,
            region: account.region!,
            sessionKey: account.sessionKey!,
            sessionToken: account.sessionToken));
  }

  static void _upload(UploadMessage message) async {
    logger.info("new isolate start");
    await RustLib.init();
    await api.uploadToS3WithConfig(
        endpoint: message.endpoint,
        bucketname: message.bucketname,
        accessKey: message.accessKey,
        sessionKey: message.sessionKey,
        region: message.region,
        p: message.p,
        obj: message.objectKey,
        sessionToken: message.sessionToken);
    logger.info("new isolate finish");
    message.sendPort?.send("ok");
    RustLib.dispose();
    print("lib dispose");
  }
}
