class HospitalModel {
  String id;
  String name;

  HospitalModel(this.id, this.name);

  HospitalModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String;
}
