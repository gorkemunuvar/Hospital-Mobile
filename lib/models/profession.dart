class ProfessionModel {
  String id;
  String name;
  String type;

  ProfessionModel({this.id, this.name, this.type});

  ProfessionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'];
}
