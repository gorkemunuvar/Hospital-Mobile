import 'dart:io';
import 'dart:ui';

import 'device_locale_helper.dart';
import 'package:hospital/core/utils/localization_service.dart';

class LocaleHelper {
  static Future<Locale> getUserSettingsLocale() async {
    String localeString = await DeviceLocaleHelper.getLocaleString();

    if (LocalizationService.localeStrings.contains(localeString)) {
      String languageCode = localeString.substring(0, 2);
      String countryCode = localeString.substring(3, 5);

      return Locale(languageCode, countryCode);
    } else {
      return getSystemLocale();
    }
  }

  static Locale getSystemLocale() {
    String systemLocale = Platform.localeName;

    final languageCode = systemLocale.substring(0, 2);
    final countryCode = systemLocale.substring(3, 5);

    return Locale(languageCode, countryCode);
  }
}
