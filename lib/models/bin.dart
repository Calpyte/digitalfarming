import 'package:digitalfarming/models/Basic.dart';

class Bin {
  String? id;
  String? name;
  String? tempBinId;
  String? code;
  Basic? variety;
  Basic? grade;
  Basic? agent;
  bool? isActive;

  Bin(
      {this.id,
      this.name,
      this.tempBinId,
      this.code,
      this.variety,
      this.grade,
      this.agent,
      this.isActive});

  Bin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tempBinId = json['tempBinId'];
    code = json['code'];
    variety = json['variety'] != null ? Basic?.fromJson(json['variety']) : null;
    grade = json['grade'] != null ? Basic?.fromJson(json['grade']) : null;
    agent = json['agent'] != null ? Basic?.fromJson(json['agent']) : null;
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tempBinId'] = tempBinId;
    data['code'] = code;
    data['variety'] = variety!.toJson();
    data['grade'] = grade!.toJson();
    data['agent'] = agent!.toJson();
    data['isActive'] = isActive;
    return data;
  }
}
