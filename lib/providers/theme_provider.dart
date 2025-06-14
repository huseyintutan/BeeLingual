import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  static const String _themeKey = 'isDarkMode';
  late SharedPreferences _prefs;

  bool get isDarkMode => _isDarkMode;

  Future<void> initializeTheme(SharedPreferences prefs) async {
    _prefs = prefs;
    _isDarkMode = _prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveTheme();
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    await _prefs.setBool(_themeKey, _isDarkMode);
  }
} 