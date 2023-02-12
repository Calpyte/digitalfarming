import 'package:digitalfarming/models/Basic.dart';

class Farmer {
  String? id;
  String? name;
  String? lastName;
  String? code;
  String? mobileNumber;
  String? email;
  String? gender;
  Basic? village;
  Basic? group;
  double? latitude;
  double? longitude;

  Farmer(
      {this.id,
      this.name,
      this.lastName,
      this.code,
      this.mobileNumber,
      this.email,
      this.gender,
      this.village,
      this.group,
      this.latitude,
      this.longitude});

  Farmer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    code = json['code'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    gender = json['gender'];
    village = json['village'] != null ? Basic.fromJson(json['village']) : null;
    group = json['group'] != null ? Basic.fromJson(json['group']) : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Farmer.fromFormJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    code = json['code'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    gender = json['gender'];
    village = json['village'];
    group = json['group'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastName'] = lastName;
    data['code'] = code;
    data['mobileNumber'] = mobileNumber;
    data['email'] = email;
    data['gender'] = gender;
    if (village != null) {
      data['village'] = village!.toJson();
    }
    if (group != null) {
      data['group'] = group!.toJson();
    }
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
