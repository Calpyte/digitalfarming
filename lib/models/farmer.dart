import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/location.dart';

class Farmer {
  String? id;
  String? name;
  String? lastName;
  String? code;
  String? mobileNumber;
  String? email;
  String? gender;
  Location? village;
  Basic? group;
  double? latitude;
  double? longitude;
  String? image;

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
      this.longitude,
        this.image,
      });

  Farmer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    code = json['code'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    gender = json['gender'];
    village = json['village'] != null ? Location.fromJson(json['village']) : null;
    group = json['group'] != null ? Basic.fromJson(json['group']) : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
  }

  Farmer.fromFormJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    code = json['code'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    village = json['village'];
    group = json['group'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
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
    data['image'] = image;
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
