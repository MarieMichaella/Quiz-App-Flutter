import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define a key to store the theme mode in SharedPreferences
const String themeModeKey = 'theme_mode';

// Enum to represent different theme modes
enum ThemeModeEnum { light, dark }

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;
  late ThemeModeEnum _themeMode;

  ThemeProvider() {
    _themeMode = ThemeModeEnum.light; 
    _themeData = _buildLightTheme(); 
    _loadThemeMode(); 
  }

  ThemeData get themeData => _themeData;

  ThemeMode get themeMode {
    return _themeMode == ThemeModeEnum.light ? ThemeMode.light : ThemeMode.dark;
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeModeEnum.light ? ThemeModeEnum.dark : ThemeModeEnum.light;
    _saveThemeMode();
    if (_themeMode == ThemeModeEnum.light) {
      _themeData = _buildLightTheme();
    } else {
      _themeData = _buildDarkTheme();
    }
    notifyListeners();
  }

  // Helper method to build light theme
  ThemeData _buildLightTheme() {
    return ThemeData.light();
  }

  // Helper method to build dark theme
  ThemeData _buildDarkTheme() {
    return ThemeData.dark();
  }

  // Load saved theme mode from SharedPreferences
  Future<void> _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeModeIndex = prefs.getInt(themeModeKey);
    if (themeModeIndex != null) {
      _themeMode = ThemeModeEnum.values[themeModeIndex];
      if (_themeMode == ThemeModeEnum.dark) {
        _themeData = _buildDarkTheme();
      }
      notifyListeners();
    }
  }

  // Save theme mode to SharedPreferences
  Future<void> _saveThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(themeModeKey, _themeMode.index);
  }
}
