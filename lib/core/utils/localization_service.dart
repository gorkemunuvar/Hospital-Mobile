import 'dart:ui';

import 'package:get/get.dart';

import '../language/en_us.dart';
import '../language/kk_kz.dart';
import '../language/ru_ru.dart';
import '../language/tr_tr.dart';

class LocalizationService extends Translations {
  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('kk', 'KZ');

  // Supported languages
  // Needs to be same order with locales
  static final langs = ['English', 'Türkçe', 'русский ', 'қазақ '];

  static final localeStrings = ['kk_KZ', 'ru_RU', 'en_US', 'tr_TR'];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('tr', 'TR'),
    Locale('ru', 'RU'),
    Locale('kk', 'KZ'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'tr_TR': trTR,
        'ru_RU': ruRU,
        'kk_KZ': kkKZ,
      };

  // Gets locale from language, and updates the locale
  static void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  // Finds language in `langs` list and returns it as Locale
  static Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }

    return Get.locale;
  }
}
