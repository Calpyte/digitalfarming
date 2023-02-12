import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/bin_contributions.dart';

class Bin {
  String? id;
  String? name;
  String? tempBinId;
  String? code;
  Basic? variety;
  Basic? grade;
  double? totalWeight;
  List<BinContribution>? contributions;

  Bin({
    this.id,
    this.name,
    this.tempBinId,
    this.code,
    this.variety,
    this.grade,
    this.totalWeight,
    this.contributions,
  });

  Bin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tempBinId = json['tempBinId'];
    code = json['code'];
    variety = json['variety'] != null ? Basic?.fromJson(json['variety']) : null;
    grade = json['grade'] != null ? Basic?.fromJson(json['grade']) : null;
    totalWeight = json['totalWeight'];
    if (json['contributions'] != null) {
      contributions = <BinContribution>[];
      json['contributions'].forEach((v) {
        contributions!.add(BinContribution.fromJson(v));
      });
    }
  }

  Bin.fromFormJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tempBinId = json['tempBinId'];
    code = json['code'];
    variety = json['variety'];
    grade = json['grade'];
    totalWeight = json['totalWeight'];
    if (json['contributions'] != null) {
      contributions = <BinContribution>[];
      json['contributions'].forEach((v) {
        contributions!.add(BinContribution.fromJson(v));
      });
    }
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
    if (contributions != null) {
      data['contributions'] = contributions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
