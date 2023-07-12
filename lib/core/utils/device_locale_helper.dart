import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class DeviceLocaleHelper {
  static Future<String> getLocaleString() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('localeSettings') ?? 'none';
  }

  static Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('localeSettings', locale.toString());
  }
}
