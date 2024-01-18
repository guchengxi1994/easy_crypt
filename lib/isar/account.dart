// ignore_for_file: constant_identifier_names

import 'package:isar/isar.dart';

part 'account.g.dart';

enum AccountType { S3, Webdav }

@collection
class Account {
  @enumerated
  late AccountType accountType;
  String? name;

  Id id = Isar.autoIncrement;
  int createAt = DateTime.now().millisecondsSinceEpoch;

  /* S3 config */
  String? endpoint;
  String? bucketname;
  String? accesskey;
  String? sessionKey;
  String? sessionToken;
  String? region;
}
