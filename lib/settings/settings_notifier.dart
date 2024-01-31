import 'package:easy_crypt/isar/database.dart';
import 'package:easy_crypt/isar/settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class SettingsNotifier extends AutoDisposeNotifier<Settings?> {
  final IsarDatabase database = IsarDatabase();

  @override
  Settings? build() {
    final item =
        database.isar!.settings.where().sortByCreateAtDesc().findFirstSync();
    return item;
  }

  newSettings({String? key}) {
    assert(key != null);
    Settings settings = Settings()..key = key ?? state?.key;
    database.isar!.writeTxnSync(() {
      database.isar!.settings.putSync(settings);
    });

    state = settings;
  }
}

final settingsProvider =
    AutoDisposeNotifierProvider<SettingsNotifier, Settings?>(
  () => SettingsNotifier(),
);
