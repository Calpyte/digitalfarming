import 'Basic.dart';

class Bin {
  String? id;
  String? name;
  Basic? variety;
  Basic? grade;

  Bin({this.id, this.name, this.variety, this.grade});
  Bin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    variety = json['variety'] != null ? Basic.fromJson(json['variety']) : null;
    grade = json['grade'] != null ? Basic.fromJson(json['grade']) : null;
  }

  Bin.fromFormJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    variety = json['variety'] != null ? Basic.fromJson(json['variety']) : null;
    grade = json['grade'] != null ? Basic.fromJson(json['grade']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['variety'] = variety;
    data['grade'] = grade;
    return data;
  }
}
