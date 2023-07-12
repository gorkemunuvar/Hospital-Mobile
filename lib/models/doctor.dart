
import 'package:flutter/cupertino.dart';

import '../core/presentation/values/values.dart';
import '../core/utils/image_helper.dart';

class DoctorModel {
  String id;
  String name;
  String surname;
  String description;
  Image image;
  String profession;
  String education;
  String experience;
  String achievements;

  DoctorModel(
    this.id,
    this.name,
    this.surname,
    this.description,
    this.image,
    this.profession,
    this.education,
    this.experience,
    this.achievements,
  );

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    Image image = getImageByBase64(json['image_base64'], AppImage.doctorDefault);

    return DoctorModel(
      json['id'],
      json['name'],
      json['surname'],
      json['description'],
      image,
      json['profession'],
      json['education'],
      json['experience'],
      json['achievements'],
    );
  }
}
