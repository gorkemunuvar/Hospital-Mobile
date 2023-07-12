import 'package:flutter/cupertino.dart';

import '/models/doctor.dart';
import '../core/presentation/values/values.dart';
import '../core/utils/image_helper.dart';

class PolyclinicModel {
  String id;
  String title;
  String description;
  Image image;
  List<DoctorModel> doctors;

  PolyclinicModel(
    this.id,
    this.title,
    this.description,
    this.image, [
    this.doctors,
  ]);

  factory PolyclinicModel.fromJson(Map<String, dynamic> json) {
    List<DoctorModel> doctors;
    Image image = getImageByBase64(json['image_base64'], AppImage.polyclinicDefault);

    if (json['doctors'] != null) {
      var doctorsJson = json['doctors'] as List;
      doctors = doctorsJson.map((doctorJson) => DoctorModel.fromJson(doctorJson)).toList();
    }

    return PolyclinicModel(
      json['id'],
      json['title'],
      json['description'],
      image,
      doctors == null ? null : doctors,
    );
  }
}
