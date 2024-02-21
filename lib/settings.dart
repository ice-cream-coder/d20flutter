import 'custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static SharedPreferences? _prefs;
  static final ValueNotifier<CustomTheme> _customThemeNotifier = ValueNotifier(CustomTheme.black);

  static final ValueNotifier<bool> _showHistoryNotifier = ValueNotifier(false);

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _customThemeNotifier.value = customTheme;
    _showHistoryNotifier.value = showHistory;
  }

  static bool get showSettings {
    return _prefs?.getBool('showSettings') ?? false;
  }

  static set showSettings(bool value) {
    _prefs?.setBool('showSettings', value);
  }

  static bool get showHistory {
    return _prefs?.getBool('showHistory') ?? false;
  }

  static set showHistory(bool value) {
    _prefs?.setBool('showHistory', value);
    _showHistoryNotifier.value = showHistory;
  }

  static CustomTheme get customTheme {
    String customThemeString = _prefs?.getString('CustomTheme') ?? 'black';
    return CustomTheme.values
        .firstWhere((e) => e.toString() == 'CustomTheme.$customThemeString', orElse: () => CustomTheme.black);
  }

  static set customTheme(CustomTheme value) {
    _prefs?.setString('CustomTheme', value.toString().split('.').last);
    _customThemeNotifier.value = value;
  }

  static ValueNotifier<CustomTheme> get themeNotifier => _customThemeNotifier;
  static ValueNotifier<bool> get showHistoryNotifier => _showHistoryNotifier;
}
