import 'package:d20flutter_new/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
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
  }

  static Theme get theme {
    String themeString = _prefs?.getString('theme') ?? 'black';
    return Theme.values.firstWhere((e) => e.toString() == 'Theme.$themeString',
        orElse: () => Theme.black);
  }

  static set theme(Theme value) {
    _prefs?.setString('theme', value.toString().split('.').last);
  }
}
