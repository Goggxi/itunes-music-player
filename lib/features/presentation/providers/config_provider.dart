import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ConfigProvider with ChangeNotifier {
  final SharedPreferences _sharedPreferences;

  ConfigProvider(this._sharedPreferences);

  static const String _themeModeKey = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  set themeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void saveThemeMode(ThemeMode value) {
    themeMode = value;
    _sharedPreferences.setInt(_themeModeKey, value.index);
  }

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
}
