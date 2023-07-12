import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/enums/enums.dart';
import '../../../states/getx_base_states.dart';
import '../../../states/getx_news_controller.dart';
import '../../../core/utils/device_locale_helper.dart';

import '../../../core/presentation/values/app_colors.dart';
import '../../utils/primary_text.dart';

class LanguageDropDownButton extends StatefulWidget {
  const LanguageDropDownButton(this.initialValue, {Key key}) : super(key: key);

  final String initialValue;

  @override
  State<LanguageDropDownButton> createState() => _LanguageDropDownButtonState();
}

class _LanguageDropDownButtonState extends State<LanguageDropDownButton> {
  String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      dropdownColor: kPrimaryGreenColor,
      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
      elevation: 16,
      underline: Container(color: Colors.transparent),
      onChanged: (String selectedValue) => setState(
        () {
          dropdownValue = selectedValue;
          Locale newLocale = _getLocaleByLangCode(selectedValue);
          Get.updateLocale(newLocale);

          final GetXBaseStates baseStates = Get.find();
          final lang = newLocale.countryCode.toLowerCase() == 'kz' ? Lang.kk : Lang.ru;
          baseStates.lang = lang;

          final GetxNewsController newsStates = Get.find();
          //newsStates.fetchNews();

          DeviceLocaleHelper.saveLocale(newLocale);
        },
      ),
      items: <String>['KK', 'RU', 'EN', 'TR'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: PrimaryText(value, Colors.white));
      }).toList(),
    );
  }

  Locale _getLocaleByLangCode(String langCode) {
    switch (langCode.toLowerCase()) {
      case 'kz':
        return Locale('kk', 'KZ');
      case 'ru':
        return Locale('ru', 'RU');
      case 'en':
        return Locale('en', 'US');
      case 'tr':
        return Locale('tr', 'TR');
      default:
        return Locale('kk', 'KZ');
    }
  }
}
