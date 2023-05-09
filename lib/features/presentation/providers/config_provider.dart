import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ConfigProvider with ChangeNotifier {
  final SharedPreferences _sharedPreferences;

  ConfigProvider(this._sharedPreferences);

  static const String _themeModeKey = 'theme_mode';
  static const String _languageCodeKey = 'language_code';

  Future<void> init() async {
    await Future.wait([
      loadThemeMode(),
      loadLanguageCode(),
    ]);
  }

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  set themeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;

  Future<void> loadThemeMode() async {
    final int? themeModeIndex = _sharedPreferences.getInt(_themeModeKey);
    if (themeModeIndex != null) {
      themeMode = ThemeMode.values[themeModeIndex];
    }
  }

  void toggleThemeMode() {
    themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    _sharedPreferences.setInt(_themeModeKey, themeMode.index);
  }

  String _languageCode = 'id';
  String get languageCode => _languageCode;
  set languageCode(String value) {
    _languageCode = value;
    notifyListeners();
  }

  Future<void> loadLanguageCode() async {
    final String? languageCode = _sharedPreferences.getString(_languageCodeKey);
    if (languageCode != null) {
      this.languageCode = languageCode;
    }
  }

  void toggleLanguageCode(String value) {
    languageCode = value;
    _sharedPreferences.setString(_languageCodeKey, languageCode);
  }

  Locale get locale => Locale(languageCode);
}
