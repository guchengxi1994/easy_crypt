import 'package:easy_crypt/isar/account.dart';
import 'package:easy_crypt/isar/encrypt_algo.dart';
import 'package:easy_crypt/isar/files.dart';
import 'package:easy_crypt/isar/transfer_records.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase {
  // ignore: avoid_init_to_null
  late Isar? isar = null;

  static final _instance = IsarDatabase._init();

  factory IsarDatabase() => _instance;

  IsarDatabase._init();

  late List<CollectionSchema<Object>> schemas = [
    FilesSchema,
    EncryptAlgorithmSchema,
    AccountSchema,
    TransferRecordsSchema
  ];

  Future initialDatabase() async {
    if (isar != null && isar!.isOpen) {
      return;
    }
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      schemas,
      name: "EasyCrypt",
      directory: dir.path,
    );
  }
}
