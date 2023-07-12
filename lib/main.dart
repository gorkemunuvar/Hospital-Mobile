import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'core/enums/enums.dart';
import 'core/utils/device_user_info_helper.dart';
import 'core/utils/locale_helper.dart';
import 'core/utils/localization_service.dart';
import 'states/getx_base_states.dart';
import 'states/getx_news_controller.dart';
import 'view/labResultsScreen/lab_results_screen.dart';
import 'view/doctorDetailScreen/doctor_detail_screen.dart';
import 'view/polyclinicDetailScreen/polyclinic_detail_screen.dart';
import 'view/appointmentResultScreen/appointment_result_screen.dart';
import 'view/appointmentsScreeen/appointments_screeen.dart';
import 'view/confirmAppointmentScreen/confirm_appointment_screen.dart';
import 'view/doctorsScreen/doctors_screen.dart';
import 'view/getAppointmentScreen/get_appointment_screen.dart';
import 'view/homeScreen/home_screen.dart';
import 'view/hospitalLocationsScreen/hospital_locations_screen.dart';
import 'view/hospitalSelectionScreen/hospital_selection_screen.dart';
import 'view/loginScreen/login_screen.dart';
import 'view/newsDetailScreen/news_detail_screen.dart';
import 'view/newsScreen/news_screen.dart';
import 'view/polyclinicsScreen/polyclinicsScreen.dart';

Locale _locale;

Future<void> main() async {
  await _initDependencies();
  runApp(AigerimApp());
}

class AigerimApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hospital',
      // theme: ThemeData(fontFamily: "Rotunda"),
      home: HomeScreen(),
      getPages: _getRoutes(),
      locale: _locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
    );
  }
}

class ControlScreen extends StatefulWidget {
  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  Future _loggedInFuture;

  @override
  void initState() {
    super.initState();

    _loggedInFuture = DeviceUserInfoHelper.savedBefore();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loggedInFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            bool loggedInBefore = snapshot.data;

            if (loggedInBefore)
              return HomeScreen();
            else
              return LoginScreen();
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

Future<void> _initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  _locale = await LocaleHelper.getUserSettingsLocale();
  print('LOCALE: ${_locale.countryCode}');

  final baseStates = Get.put(GetXBaseStates());
  if (_locale.countryCode.toLowerCase() == 'kz') {
    baseStates.lang = Lang.kk;
  }

  print('BASE STATE LANG: ${baseStates.lang}');
  Get.put(GetxNewsController());
}

_getRoutes() => [
      GetPage(name: '/appointments', page: () => AppointmentsScreen()),
      GetPage(name: '/appointmentResult', page: () => AppointmentResultScreen()),
      GetPage(name: '/confirmAppointment', page: () => ConfirmAppointmentScreen()),
      GetPage(name: '/doctors', page: () => DoctorsScreen()),
      GetPage(name: '/doctorDetail', page: () => DoctorDetailScreen()),
      GetPage(name: '/getAppointment', page: () => GetAppointmentScreen()),
      GetPage(name: '/home', page: () => HomeScreen()),
      GetPage(name: '/hospitalSelection', page: () => HospitalSelectionScreen()),
      GetPage(name: '/hospitalLocations', page: () => HospitalLocationsScreen()),
      GetPage(name: '/login', page: () => LoginScreen()),
      GetPage(name: '/news', page: () => NewsScreen()),
      GetPage(name: '/newsDetail', page: () => NewsDetailScreen()),
      GetPage(name: '/polyclinics', page: () => PolyclinicsScreen()),
      GetPage(name: '/polyclinicDetail', page: () => PolyclinicDetailScreen()),
      GetPage(name: '/labResults', page: () => LabResultsScreen()),
    ];
