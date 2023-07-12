import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital/states/getx_appointment_info.dart';
import 'package:intl/intl.dart';

import '/view/utils/my_appbar.dart';
import '/view/utils/primary_button.dart';
import '/view/utils/primary_text.dart';
import '/view/utils/primary_text_field.dart';
import '../../controller/patient.dart';
import '../../core/presentation/values/app_colors.dart';
import '../../core/utils/device_user_info_helper.dart';
import '../../core/utils/snackbar_helper.dart';
import '../../models/patient.dart';
import '../../states/getx_base_states.dart';
import '../../states/getx_my_appointments.dart';

String initialDateString = "${DateTime.now().toLocal()}".split(' ')[0];
String pickedDateString = initialDateString;

final TextEditingController _nameController = TextEditingController();
final TextEditingController _surnameController = TextEditingController();
final TextEditingController _phoneNumberController = TextEditingController();

final GetXBaseStates _baseStates = Get.find();
final GetxAppointmentInfoStates _appointmentStates = Get.find();

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future _getInputsFuture;

  @override
  void initState() {
    super.initState();
    _getInputsFuture = _getInputs();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => _onPagePressed(context),
      child: Scaffold(
        appBar: MyAppBar(
          title: 'loginPage_header'.tr,
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
                    child: _InputFieldsFutureBuilder(future: _getInputsFuture),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 32, right: 32, bottom: 20, top: 0),
                    child: SizedBox(
                      width: size.width,
                      child: PrimaryButton(
                        'loginPage_nextButton'.tr,
                        hasForwardIcon: true,
                        onPressed: _onNextButtonPressed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _getInputs() async {
    Map<String, dynamic> inputs;
    bool savedBefore = await DeviceUserInfoHelper.savedBefore();

    if (savedBefore) {
      inputs = await DeviceUserInfoHelper.readInfo();
      return inputs;
    }

    return false;
  }

  void _cleanFields() {
    pickedDateString = initialDateString;
    _nameController.clear();
    _surnameController.clear();
    _phoneNumberController.clear();
  }
}

class _InputFieldsFutureBuilder extends StatelessWidget {
  const _InputFieldsFutureBuilder({@required this.future, Key key}) : super(key: key);

  final Future future;

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              dynamic inputs = snapshot.data;

              if (inputs != false) {
                pickedDateString = inputs['user_birthday'];

                return _InputFields(
                  inputs: inputs,
                  savedBefore: true,
                );
              }

              return _InputFields();
            }
          }

          return Center(child: CircularProgressIndicator());
        },
      );
}

class _InputFields extends StatefulWidget {
  const _InputFields({this.inputs, this.savedBefore = false, Key key}) : super(key: key);

  final Map<String, dynamic> inputs;
  final bool savedBefore;

  @override
  State<_InputFields> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<_InputFields> {
  @override
  void initState() {
    super.initState();

    if (widget.savedBefore) {
      _nameController.text = widget.inputs['user_name'];
      _surnameController.text = widget.inputs['user_surname'];
      _phoneNumberController.text = widget.inputs['user_phone_number'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _IconHeader(Icon(Icons.text_fields_sharp, color: kPrimaryGreenColor), 'loginPage_nameLabel'.tr),
        const SizedBox(height: 8),
        PrimaryTextField(hintText: 'loginPage_nameTextFieldHint'.tr, controller: _nameController),
        const SizedBox(height: 20),
        _IconHeader(Icon(Icons.text_fields_sharp, color: kPrimaryGreenColor), 'loginPage_surnameLabel'.tr),
        const SizedBox(height: 8),
        PrimaryTextField(hintText: 'loginPage_surnameTextFieldHint'.tr, controller: _surnameController),
        const SizedBox(height: 20),
        _IconHeader(Icon(Icons.phone, color: kPrimaryGreenColor), 'loginPage_phoneLabel'.tr),
        const SizedBox(height: 8),
        PrimaryTextField(
            onlyDigits: true, hintText: 'loginPage_phoneTextFieldHint'.tr, controller: _phoneNumberController),
        const SizedBox(height: 20),
        _IconHeader(Icon(Icons.date_range_outlined, color: kPrimaryGreenColor), 'loginPage_birthdayLabel'.tr),
        const SizedBox(height: 8),
        BirthdayInputField(),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _IconHeader extends StatelessWidget {
  const _IconHeader(this.icon, this.title, {Key key}) : super(key: key);

  final Icon icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [icon, const SizedBox(width: 5), PrimaryText(title, kPrimaryGreenColor)],
    );
  }
}

class BirthdayInputField extends StatefulWidget {
  @override
  _BirthdayInputFieldState createState() => _BirthdayInputFieldState();
}

class _BirthdayInputFieldState extends State<BirthdayInputField> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 40,
      child: OutlinedButton(
        onPressed: () => _selectDate(context),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            pickedDateString,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 0.5),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1930, 8),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          child: child,
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: kPrimaryGreenColor),
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
        pickedDateString = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }
}

void _onPagePressed(BuildContext context) {
  final currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

Future<void> _onNextButtonPressed() async {
  final selectedDateTime = DateTime.parse(pickedDateString);

  if (!_areInputsFilled()) {
    SnackbarHelper.show(
      'loginPage_snackbarFillAllTheFieldsTitle'.tr,
      'loginPage_snackbarFillAllTheFieldsMessage'.tr,
      Colors.red[700],
    );
  } else if (!_isDateTimeValid(selectedDateTime)) {
    SnackbarHelper.show(
      'loginPage_snackbarBirthdayInvalidTitle'.tr,
      'loginPage_snackbarBirthdayInvalidMessage'.tr,
      Colors.red[700],
    );
  } else {
    PatientModel patient = PatientModel(
      name: _nameController.text.trim(),
      surname: _surnameController.text.trim(),
      phoneNumber: _phoneNumberController.text.trim(),
      birthday: _formatDateTimeString(pickedDateString.trim()),
    );

    _baseStates.patient = patient;
    _saveUserInfoOnDevice(
      patient.name,
      patient.surname,
      patient.phoneNumber,
      pickedDateString.trim(),
    );

    bool gotPatientId = await _createPatientIdIfNotExist(patient);
    if (gotPatientId) {
      //_cleanFields();
      _logUserInfo(patient);

      String pageName = Get.arguments;
      if (pageName == '/appointments') {
        Get.put(GetxMyAppointments());
      }

      Get.toNamed(pageName);
    } else {
      SnackbarHelper.show(
        'loginPage_snackbarWarningTitle'.tr,
        'loginPage_snackbarWarningMessage'.tr,
        Colors.red[700],
      );
    }
  }
}

bool _areInputsFilled() {
  bool nameValidation = _nameController.text != '';
  bool surnameValidation = _surnameController.text != '';
  bool phoneNumberValidation = _phoneNumberController.text != '';
  bool birthdayValidation = pickedDateString != initialDateString;

  return nameValidation && surnameValidation && phoneNumberValidation && birthdayValidation;
}

bool _isDateTimeValid(DateTime selectedDateTime) => selectedDateTime.isBefore(DateTime.now());

String _formatDateTimeString(String date) {
  DateTime dateTime = DateTime.parse(date);
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  String formatted = formatter.format(dateTime);

  return formatted;
}

//Birthday format <yyyy-mm-dd>
Future<void> _saveUserInfoOnDevice(
  String name,
  String surname,
  String phoneNumber,
  String birthday,
) async {
  DeviceUserInfoHelper.save(name, surname, phoneNumber, birthday);
}

///Birthday format <dd/mm/yyyy>
Future<bool> _createPatientIdIfNotExist(PatientModel patient) async {
  String patientId = await PatientController.createPatientIdIfNotExist(patient);
  _baseStates.patient.id = patientId;

  _appointmentStates.appointment.patientId = patientId;
  _appointmentStates.appointment.patientName = patient.name;
  _appointmentStates.appointment.patientSurname = patient.surname;
  _appointmentStates.appointment.patientBirthday = patient.birthday;

  print('PATIENT ID: $patientId');

  return patientId != null && patientId.isNotEmpty && patientId != '-1';
}

void _logUserInfo(PatientModel patient) => print('PATIENT INFO: ${patient.toJson()}');
