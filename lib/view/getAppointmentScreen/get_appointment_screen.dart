import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/view/utils/my_appbar.dart';
import '../../core/presentation/values/app_colors.dart';
import '../../models/doctor.dart';
import '../../models/hospital.dart';
import '../../models/polyclinic.dart';
import '../../models/profession.dart';
import '../../states/getx_appointment_info.dart';
import '../../states/getx_base_states.dart';
import '../utils/primary_button.dart';
import '../utils/primary_text.dart';
import '../utils/searchable_dropdown.dart';
import 'utils/horizontal_listivew.dart';

GetxAppointmentInfoStates _appointmentStates;

class GetAppointmentScreen extends StatefulWidget {
  @override
  _GetAppointmentScreenState createState() => _GetAppointmentScreenState();
}

class _GetAppointmentScreenState extends State<GetAppointmentScreen> {
  @override
  void initState() {
    super.initState();

    _appointmentStates = Get.find();
    _appointmentStates.fetchHospitals();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: MyAppBar(title: 'newAppointmentPage_header'.tr, hasBackButton: true),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Scrollbar(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
                child: _InputFields(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20, top: 0),
                  child: _CreateAppointmentButton(size: size),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputFields extends StatelessWidget {
  const _InputFields({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoLabel('assets/icons/building.png', 'Hastane Seçimi'.tr),
        const SizedBox(height: 8),
        const _HospitalsDropDown(),
        const SizedBox(height: 20),
        _InfoLabel('assets/icons/clinic.png', 'newAppointmentPage_polyclinic'.tr),
        const SizedBox(height: 8),
        const _PolyclinicsDropDown(),
        const SizedBox(height: 20),
        _InfoLabel('assets/icons/clinic.png', 'newAppointmentPage_profession'.tr),
        const SizedBox(height: 8),
        const _ProfessionsDropDown(),
        const SizedBox(height: 20),
        const _DoctorsField(),
        const SizedBox(height: 20),
        const _AvailableDatesListView(),
        const SizedBox(height: 20),
        const _AvailableTimesListView(),
      ],
    );
  }
}

class _InfoLabel extends StatelessWidget {
  final String asset;
  final String title;

  const _InfoLabel(this.asset, this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(AssetImage(asset), color: kPrimaryGreenColor),
        SizedBox(width: 5),
        PrimaryText(title, kPrimaryGreenColor),
      ],
    );
  }
}

class _HospitalsDropDown extends StatelessWidget {
  const _HospitalsDropDown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetxAppointmentInfoStates>(
      builder: (c) {
        if (c.areHospitalsLoaded)
          return SearchableDropdown<HospitalModel>(
            c.hospitals,
            (HospitalModel hospital) => hospital.name,
            onChanged: _hospitalsDropDownOnChanged,
          );

        return SearchableDropdown([], null, enabled: false);
      },
    );
  }
}

class _PolyclinicsDropDown extends StatelessWidget {
  const _PolyclinicsDropDown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetxAppointmentInfoStates>(
      builder: (c) {
        Widget searchableDropdown;
        final GetXBaseStates baseStates = Get.find();

        PolyclinicModel selectedPolyclinic = baseStates.polyclinicModel != null ? baseStates.polyclinicModel : null;
        if (selectedPolyclinic != null) {
          _polyclinicsDropDownOnChanged(selectedPolyclinic);
        }

        if (c.arePolyclinicsLoaded && c.isHospitalSelected) {
          searchableDropdown = SearchableDropdown<PolyclinicModel>(
            c.polyclinics,
            (PolyclinicModel polyclinic) => polyclinic.title,
            selectedItem: selectedPolyclinic,
            onChanged: _polyclinicsDropDownOnChanged,
          );

          baseStates.polyclinicModel = null;
        } else {
          searchableDropdown = SearchableDropdown([], null, enabled: false);
        }

        return searchableDropdown;
      },
    );
  }
}

class _ProfessionsDropDown extends StatelessWidget {
  const _ProfessionsDropDown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetxAppointmentInfoStates>(
      builder: (c) {
        if (c.areProfessionsLoaded && c.isPolyclinicSelected)
          return SearchableDropdown<ProfessionModel>(
            c.professions,
            (ProfessionModel profession) => profession.name,
            onChanged: _professionsDropDownOnChanged,
          );

        return SearchableDropdown([], null, enabled: false);
      },
    );
  }
}

class _DoctorsField extends StatelessWidget {
  const _DoctorsField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetxAppointmentInfoStates>(
      builder: (c) {
        final selectedProfession = c.appointment.profession;
        if (c.areDoctorsLoaded && c.isProfessionSelected && selectedProfession.type != 'L') {
          return Column(
            children: [
              _InfoLabel('assets/icons/doctor.png', 'newAppointmentPage_doctor'.tr),
              const SizedBox(height: 8),
              SearchableDropdown<DoctorModel>(
                c.doctors,
                (DoctorModel doctor) => '${doctor.name} ${doctor.surname}',
                onChanged: _doctorsDropDownOnChanged,
              ),
            ],
          );
        }

        bool shouldCheckDoctorSelected = c.isProfessionSelected && c.appointment.profession.type != 'L';

        return shouldCheckDoctorSelected ? const Center(child: CircularProgressIndicator()) : const SizedBox.shrink();
      },
    );
  }
}

class _AvailableDatesListView extends StatelessWidget {
  const _AvailableDatesListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetxAppointmentInfoStates>(
      builder: (c) {
        bool shouldCheckDoctorSelected = c.isProfessionSelected && c.appointment.profession.type != 'L';
        bool statement = shouldCheckDoctorSelected
            ? c.areAvailableDatesLoaded && c.isPolyclinicSelected && c.isProfessionSelected && c.isDoctorSelected
            : c.areAvailableDatesLoaded && c.isPolyclinicSelected && c.isProfessionSelected;

        if (statement)
          return Column(
            children: [
              c.availableAppointmentDates != null && c.availableAppointmentDates.length > 0
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.date_range_outlined, color: kPrimaryGreenColor),
                            SizedBox(width: 5),
                            PrimaryText('newAppointmentPage_availableDates'.tr, kPrimaryGreenColor),
                          ],
                        ),
                        SizedBox(height: 8),
                        HorizontalListView(c.availableAppointmentDates, onTap: _availableDatesOnTap)
                      ],
                    )
                  : Center(child: PrimaryText('newAppointmentPage_appointmentNotFound'.tr, Colors.black, fontSize: 15)),
            ],
          );

        bool returnStatement = shouldCheckDoctorSelected
            ? c.isPolyclinicSelected && c.isProfessionSelected && c.isDoctorSelected && !c.areAvailableDatesLoaded
            : c.isPolyclinicSelected && c.isProfessionSelected && !c.areAvailableDatesLoaded;

        if (returnStatement) {
          return Center(child: CircularProgressIndicator());
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _AvailableTimesListView extends StatelessWidget {
  const _AvailableTimesListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetxAppointmentInfoStates>(
      builder: (c) {
        if (c.areAvailableTimesLoaded && c.isPolyclinicSelected && c.isProfessionSelected && c.isAvailableDateSelected)
          return Column(
            children: [
              c.availableAppointmentTimes != null && c.availableAppointmentTimes.length > 0
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.alarm, color: kPrimaryGreenColor),
                            SizedBox(width: 5),
                            PrimaryText('newAppointmentPage_availableTimes'.tr, kPrimaryGreenColor),
                          ],
                        ),
                        SizedBox(height: 8),
                        HorizontalListView(c.availableAppointmentTimes, onTap: _availableTimesOnTap)
                      ],
                    )
                  : Center(child: PrimaryText('newAppointmentPage_appointmentNotFound'.tr, Colors.black, fontSize: 15)),
            ],
          );

        if (c.areAvailableTimesLoaded == false && c.isAvailableDateSelected) {
          return Center(child: CircularProgressIndicator());
        }

        return Container();
      },
    );
  }
}

class _CreateAppointmentButton extends StatelessWidget {
  const _CreateAppointmentButton({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: GetBuilder<GetxAppointmentInfoStates>(
        builder: (c) {
          if (c.isAvailableTimeSelected) {
            return PrimaryButton(
              'newAppointmentPage_createButton'.tr,
              onPressed: () => Get.toNamed('/confirmAppointment'),
            );
          }

          return PrimaryButton('newAppointmentPage_createButton'.tr, enable: false);
        },
      ),
    );
  }
}

void _hospitalsDropDownOnChanged(HospitalModel selectedHospital) {
  print('SELECTED HOSPITAL ID: ${selectedHospital.id}');

  _appointmentStates.isHospitalSelected = true;
  _appointmentStates.isPolyclinicSelected = false;
  _appointmentStates.isProfessionSelected = false;
  _appointmentStates.isDoctorSelected = false;
  _appointmentStates.isAvailableDateSelected = false;
  _appointmentStates.isAvailableTimeSelected = false;

  _appointmentStates.appointment.hospital = selectedHospital;

  _appointmentStates.update();
  _appointmentStates.fetchPolyclinics();
}

void _polyclinicsDropDownOnChanged(PolyclinicModel selectedPolyclinic) {
  print('SELECTED POLYCLINIC ID: ${selectedPolyclinic.id}');

  _appointmentStates.isPolyclinicSelected = true;
  _appointmentStates.isProfessionSelected = false;
  _appointmentStates.isDoctorSelected = false;
  _appointmentStates.isAvailableDateSelected = false;
  _appointmentStates.isAvailableTimeSelected = false;

  _appointmentStates.appointment.polyclinic = selectedPolyclinic;

  _appointmentStates.update();
  _appointmentStates.fetchProfessionsByPolyclinicId(selectedPolyclinic.id);
}

void _professionsDropDownOnChanged(ProfessionModel selectedProfession) {
  print('SELECTED PROFESSION ID: ${selectedProfession.id}');
  print('SELECTED PROFESSION TYPE: ${selectedProfession.type}');

  _appointmentStates.isProfessionSelected = true;
  _appointmentStates.isDoctorSelected = false;
  _appointmentStates.isAvailableDateSelected = false;
  _appointmentStates.isAvailableTimeSelected = false;
  _appointmentStates.appointment.profession = selectedProfession;

  _appointmentStates.update();

  if (selectedProfession.type != 'L') {
    _appointmentStates.fetchDoctorsByProfessionId(selectedProfession.id);
  } else {
    final professionId = _appointmentStates.appointment.profession.id;
    _appointmentStates.fetchAvailableDatesByProfessionId(professionId);
  }
}

void _doctorsDropDownOnChanged(DoctorModel selectedDoctor) {
  print('SELECTED DOCTOR ID: ${selectedDoctor.id}');

  _appointmentStates.isDoctorSelected = true;
  _appointmentStates.isAvailableDateSelected = false;
  _appointmentStates.isAvailableTimeSelected = false;
  _appointmentStates.appointment.doctor = selectedDoctor;

  _appointmentStates.update();
  final doctorId = selectedDoctor.id;
  final professionId = _appointmentStates.appointment.profession.id;

  _appointmentStates.fetchAvailableDatesByDoctorId(doctorId, professionId);
}

void _availableDatesOnTap(String selectedDate) {
  print('SELECTED DATE: $selectedDate');

  _appointmentStates.isAvailableDateSelected = true;
  _appointmentStates.isAvailableTimeSelected = false;
  _appointmentStates.appointment.date = selectedDate;

  _appointmentStates.update();
  if (_appointmentStates.isDoctorSelected) {
    final doctorId = _appointmentStates.appointment.doctor.id;
    _appointmentStates.fetchAvailableTimes(selectedDate, doctorId: doctorId);
  } else {
    _appointmentStates.fetchAvailableTimes(selectedDate);
  }
}

void _availableTimesOnTap(String selectedTime) {
  print('SELECTED TIME: $selectedTime');

  _appointmentStates.isAvailableTimeSelected = true;
  _appointmentStates.appointment.time = selectedTime;

  _appointmentStates.update();
}
