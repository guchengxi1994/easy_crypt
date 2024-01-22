import 'package:easy_crypt/isar/transfer_records.dart';
import 'package:isar/isar.dart';

import 'encrypt_algo.dart';

part 'files.g.dart';

/// job type, includes `encryption` and `decryption`
enum JobType { encryption, decryption }

/// files to encrypt and decrypt
@collection
class Files {
  @enumerated
  late JobType jobType;
  Id id = Isar.autoIncrement;
  int createAt = DateTime.now().millisecondsSinceEpoch;
  String? filePath;
  String? savePath;

  /// password
  String? key;

  final transferRecords = IsarLinks<TransferRecords>();

  /// WIP
  final account = IsarLink<EncryptAlgorithm>();
}
