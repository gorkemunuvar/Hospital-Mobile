import 'package:shared_preferences/shared_preferences.dart';

class DeviceUserInfoHelper {
  static Future<bool> savedBefore() async {
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool('hospital_is_personal_info_saved');

    if (result == null) return false;
    return true;
  }

  static Future<Map<String, dynamic>> readInfo() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'user_name': prefs.getString('hospital_user_name'),
      'user_surname': prefs.getString('hospital_user_surname'),
      'user_phone_number': prefs.getString('hospital_user_phone_number'),
      'user_birthday': prefs.getString('hospital_user_birthday'),
    };
  }

  static Future<bool> save(
    String name,
    String surname,
    String phoneNumber,
    String birthday,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    bool state1 = await prefs.setBool('hospital_is_personal_info_saved', true);
    bool state2 = await prefs.setString('hospital_user_name', name);
    bool state3 = await prefs.setString('hospital_user_surname', surname);
    bool state4 = await prefs.setString('hospital_user_phone_number', phoneNumber);
    bool state5 = await prefs.setString('hospital_user_birthday', birthday);

    if (state1 && state2 && state3 && state4 && state5) return true;
    return false;
  }

  static Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('hospital_is_personal_info_saved');
    await prefs.remove('hospital_user_name');
    await prefs.remove('hospital_user_surname');
    await prefs.remove('hospital_user_phone_number');
    await prefs.remove('hospital_user_birthday');
  }
}
