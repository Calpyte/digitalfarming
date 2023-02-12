import 'package:digitalfarming/models/Basic.dart';

class Location {
  String? id;
  String? name;
  Basic? country;
  Basic? state;
  Basic? district;
  Basic? taluk;

  Location({this.id, this.name, this.state, this.district, this.taluk, this.country});

  Location.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'] != null ? Basic.fromJson(json['state']) : null;
    country = json['country'] != null ? Basic.fromJson(json['country']) : null;
    district =
    json['district'] != null ? Basic.fromJson(json['district']) : null;
    taluk = json['taluk'] != null ? Basic.fromJson(json['taluk']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (state != null) {
      data['state'] = state!.toJson();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    if (taluk != null) {
      data['taluk'] = taluk!.toJson();
    }
    return data;
  }
}