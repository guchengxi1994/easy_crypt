import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final _instance = LocalStorage._init();

  factory LocalStorage() => _instance;

  static SharedPreferences? _storage;

  LocalStorage._init() {
    _initStorage();
  }

  _initStorage() async {
    _storage ??= await SharedPreferences.getInstance();
  }

  String getCurrentLocale() {
    return _storage!.getString("currentLocale") ?? "zh-CN";
  }

  Future setCurrentLocale(String locale) async {
    await _storage!.setString("currentLocale", locale);
  }
}
