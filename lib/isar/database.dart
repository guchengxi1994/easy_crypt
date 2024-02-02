import 'package:easy_crypt/common/logger.dart';
import 'package:easy_crypt/isar/datasource.dart';
import 'package:easy_crypt/isar/encrypt_algo.dart';
import 'package:easy_crypt/isar/files.dart';
import 'package:easy_crypt/isar/process_records.dart';
import 'package:easy_crypt/isar/settings.dart';
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
    DatasourceSchema,
    ProcessRecordsSchema,
    SettingsSchema
  ];

  Future initialDatabase() async {
    if (isar != null && isar!.isOpen) {
      return;
    }
    final dir = await getApplicationSupportDirectory();
    logger.info("create database in ${dir.path}");

    isar = await Isar.open(
      schemas,
      name: "EasyCrypt",
      directory: dir.path,
    );
  }
}
