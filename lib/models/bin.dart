import 'package:digitalfarming/models/Basic.dart';

class Bin {
  String? id;
  String? name;
  String? tempBinId;
  String? code;
  Basic? variety;
  Basic? grade;
  double? totalWeight;

  Bin({
    this.id,
    this.name,
    this.tempBinId,
    this.code,
    this.variety,
    this.grade,
    this.totalWeight,
  });

  Bin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tempBinId = json['tempBinId'];
    code = json['code'];
    variety = json['variety'] != null ? Basic?.fromJson(json['variety']) : null;
    grade = json['grade'] != null ? Basic?.fromJson(json['grade']) : null;
    totalWeight = json['totalWeight'];
  }

  Bin.fromFormJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tempBinId = json['tempBinId'];
    code = json['code'];
    variety = json['variety'];
    grade = json['grade'];
    totalWeight = json['totalWeight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tempBinId'] = tempBinId;
    data['code'] = code;
    data['variety'] = variety!.toJson();
    data['grade'] = grade!.toJson();
    data['totalWeight'] = totalWeight;
    return data;
  }
}
