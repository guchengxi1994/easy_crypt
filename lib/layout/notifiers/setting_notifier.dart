import 'package:easy_crypt/common/local_storage.dart';
import 'package:easy_crypt/gen/strings.g.dart';
import 'package:easy_crypt/layout/models/setting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsNotifier extends Notifier<SettingsState> {
  final LocalStorage localStorage = LocalStorage();

  @override
  SettingsState build() {
    final currentLocale = localStorage.getCurrentLocale();

    return SettingsState(
      currentLocale: currentLocale,
    );
  }

  changeCurrentLocale(String locale) async {
    if (state.currentLocale != locale) {
      state = state.copyWith(currentLocale: locale);
      LocaleSettings.setLocaleRaw(locale);
      await localStorage.setCurrentLocale(locale);
    }
  }
}

final settingsNotifier =
    NotifierProvider<SettingsNotifier, SettingsState>(() => SettingsNotifier());
