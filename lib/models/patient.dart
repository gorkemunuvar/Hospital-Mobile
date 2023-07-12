class PatientModel {
  String id;
  String name;
  String surname;
  String phoneNumber;
  String birthday;

  PatientModel({this.id, this.name, this.surname, this.phoneNumber, this.birthday});

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(id: json['id']);
  }

  Map<String, String> toJson() {
    return {
      'name': name,
      'surname': surname,
      'phone_number': phoneNumber,
      'birthday': birthday,
    };
  }
}
