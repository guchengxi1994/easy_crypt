class SettingsState {
  final String currentLocale;
  final List<String> supportLocales;

  SettingsState({
    this.currentLocale = "zh-CN",
    this.supportLocales = const ["zh-CN", "en"],
  });

  SettingsState copyWith({
    String? currentLocale,
    List<String>? supportLocales,
  }) {
    return SettingsState(
      currentLocale: currentLocale ?? this.currentLocale,
      supportLocales: supportLocales ?? this.supportLocales,
    );
  }
}
