// @dart=2.9

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:telegram_clone/common/constants/shared_prefs_keys.dart';
import 'package:telegram_clone/data/storage_service.dart';

class ThemeNotifier with ChangeNotifier {
  // ignore: non_constant_identifier_names
  static bool IS_LIGHT_MODE;

  // custom color
  Color tagColor;
  Color activeUserMessageColor;

  // DARK theme
  final _darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black54,
  );

  // LIGHT theme
  final _lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Color(0xff0088CC),
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.grey,
  );

  ThemeData _themeData;

  ThemeData getTheme() => _themeData;

  bool _isLightMode;

  bool get isLightMode => _isLightMode;

  ThemeNotifier() {
    _themeData = IS_LIGHT_MODE ? _lightTheme : _darkTheme;
    tagColor = IS_LIGHT_MODE ? Colors.green : Color(0xff0088CC);
    activeUserMessageColor = IS_LIGHT_MODE ? Colors.lightGreenAccent : Colors.blueAccent;

    _isLightMode = IS_LIGHT_MODE;
  }

  void flipMode() {
    if (_isLightMode) {
      debugPrint('Setting dark mode');
      _setDarkMode();
    } else {
      _setLightMode();
    }

    _isLightMode = !_isLightMode;
    debugPrint('isLightMode -> $isLightMode');
    notifyListeners();
  }

  void _setDarkMode() async {
    _themeData = _darkTheme;
    tagColor = Color(0xff0088CC);
    activeUserMessageColor = Colors.blueAccent;
    StorageService.saveData(SharedPrefsKeys.THEME_MODE_KEY_IS_LIGHT_MODE, false);
  }

  void _setLightMode() async {
    _themeData = _lightTheme;
    tagColor = Colors.green;
    activeUserMessageColor = Colors.lightGreenAccent;
    StorageService.saveData(SharedPrefsKeys.THEME_MODE_KEY_IS_LIGHT_MODE, true);
  }
}
