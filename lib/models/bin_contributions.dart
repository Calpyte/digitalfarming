import 'package:digitalfarming/models/Basic.dart';

class BinContribution {
  Basic? farmer;
  Basic? variety;
  Basic? grade;
  double? weight;
  double? contributionPercentage;

  BinContribution(
      {this.farmer,
        this.variety,
        this.grade,
        this.weight,
        this.contributionPercentage});

  BinContribution.fromJson(Map<String, dynamic> json) {
    farmer =
    json['farmer'] != null ? Basic.fromJson(json['farmer']) : null;
    variety =
    json['variety'] != null ? Basic.fromJson(json['variety']) : null;
    grade = json['grade'] != null ? Basic.fromJson(json['grade']) : null;
    weight = json['weight'];
    contributionPercentage = json['contributionPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (farmer != null) {
      data['farmer'] = farmer!.toJson();
    }
    if (variety != null) {
      data['variety'] = variety!.toJson();
    }
    if (grade != null) {
      data['grade'] = grade!.toJson();
    }
    data['weight'] = weight;
    data['contributionPercentage'] = contributionPercentage;
    return data;
  }
}