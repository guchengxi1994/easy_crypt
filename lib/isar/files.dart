import 'package:easy_crypt/isar/transfer_records.dart';
import 'package:isar/isar.dart';

part 'files.g.dart';

/// job type, includes `encryption` and `decryption`
enum JobType { encrypt, decrypt, encryptAndTransfer, transfer }

/// files to encrypt and decrypt
@collection
class Files {
  @enumerated
  late JobType jobType;
  Id id = Isar.autoIncrement;
  int createAt = DateTime.now().millisecondsSinceEpoch;
  String? filePath;
  String? encryptedSavePath;

  /// password
  String? key;

  final transferRecords = IsarLinks<TransferRecords>();
}
