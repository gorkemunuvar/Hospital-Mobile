import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hospital/states/getx_appointment_info.dart';

import '../../core/enums/enums.dart';
import '../../core/presentation/values/app_colors.dart';
import '../utils/my_appbar.dart';
import '../utils/primary_button.dart';
import '../utils/primary_text.dart';

class AppointmentResultScreen extends StatelessWidget {
  final AppointmentResult result = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    AppointmentResult result = Get.arguments;
    final shouldUserGoBack = result != AppointmentResult.confirmed;

    return Scaffold(
      appBar: MyAppBar(title: 'İşlem Sonucu', hasBackButton: shouldUserGoBack),
      body: SizedBox(
        height: size.height,
        child: Center(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _InfoIcon(result),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: _InfoMessage(_getInfoMessage(result)),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20, top: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryButton('Ana Sayfa', onPressed: _onHomePageBtnPressed),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoIcon extends StatelessWidget {
  const _InfoIcon(this.result, {Key key}) : super(key: key);

  final AppointmentResult result;

  static final _confirmedIcon =
      SvgPicture.asset('assets/svg/confirmed.svg', width: 85.0, height: 85.0, color: kPrimaryGreenColor);

  static final _alreadyTakenIcon =
      SvgPicture.asset('assets/svg/warning.svg', width: 85.0, height: 85.0, color: kPrimaryGreenColor);

  static final _denidedIcon = SvgPicture.asset('assets/svg/denied.svg', width: 75.0, height: 75.0, color: Colors.red);

  @override
  Widget build(BuildContext context) {
    if (result == AppointmentResult.confirmed) return _confirmedIcon;
    if (result == AppointmentResult.alreadyTaken) return _alreadyTakenIcon;
    if (result == AppointmentResult.error) return _denidedIcon;
    return _denidedIcon;
  }
}

class _InfoMessage extends StatelessWidget {
  const _InfoMessage(this.message, {Key key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return PrimaryText(
      message,
      Colors.black,
      maxLines: 4,
      textAlign: TextAlign.center,
    );
  }
}

const _confirmedMsg =
    'Randevunuz onaylandı. Lütfen randevu saatinizden en az 15 dakika önce hastanede olmaya dikkat ediniz.';
const _alreadyTakenMsg = 'Randevu önceden alındı. Lütfen başka bir tarih veya saate almayı deneyin.';
const _deniedMsg = 'Randevu isteğiniz onaylanamadı.';

String _getInfoMessage(AppointmentResult result) {
  if (result == AppointmentResult.confirmed) return _confirmedMsg;
  if (result == AppointmentResult.alreadyTaken) return _alreadyTakenMsg;
  if (result == AppointmentResult.error) return _deniedMsg;
  return _deniedMsg;
}

_onHomePageBtnPressed() {
  final GetxAppointmentInfoStates appointmentStates = Get.find();
  appointmentStates.refreshStates();

  Get.offAllNamed('/home');
}
