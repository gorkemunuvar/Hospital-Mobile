import 'doctor.dart';
import 'hospital.dart';
import 'polyclinic.dart';
import 'profession.dart';

class AppointmentModel {
  AppointmentModel({
    this.id,
    this.hospital,
    this.polyclinic,
    this.profession,
    this.doctor,
    this.date,
    this.time,
    this.doctorId,
    this.doctorName,
    this.doctorSurname,
    this.patientId,
    this.patientName,
    this.patientSurname,
    this.patientFather,
    this.patientBirthday,
    this.note,
  });

  String id;
  HospitalModel hospital;
  PolyclinicModel polyclinic;
  ProfessionModel profession;
  DoctorModel doctor;
  String date;
  String time;
  String doctorId;
  String doctorName;
  String doctorSurname;
  String patientId;
  String patientName;
  String patientSurname;
  String patientFather;
  String patientBirthday;
  String note;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    final profession = ProfessionModel(id: json['profession_id'], name: json['profession_name']);

    return AppointmentModel(
        id: json['id'],
        date: json['date'],
        time: json['time'],
        profession: profession,
        doctorId: json['doctor_id'],
        doctorName: json['doctor_name'],
        doctorSurname: json['doctor_surname'],
        patientName: json['patient_name'],
        patientSurname: json['patient_surname'],
        patientFather: json['patient_father'],
        patientBirthday: json['patient_birthday']);
  }
}
