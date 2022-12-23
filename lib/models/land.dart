import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/farm_coordinates.dart';

class Land {
  String? id;
  String? name;
  String? totalArea;
  String? cultivatedArea;
  double? latitude;
  double? longitude;
  Basic? farmer;
  List<FarmCoordinates>? farmCoordinates;

  Land(
      {this.id,
      this.name,
      this.totalArea,
      this.cultivatedArea,
      this.latitude,
      this.longitude,
      this.farmer,
      this.farmCoordinates});

  Land.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalArea = json['totalArea'];
    cultivatedArea = json['cultivatedArea'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    farmer = json['farmer'] != null ? Basic.fromJson(json['farmer']) : null;
    if (json['farmCoordinates'] != null) {
      farmCoordinates = <FarmCoordinates>[];
      json['farmCoordinates'].forEach((v) {
        farmCoordinates!.add(FarmCoordinates.fromJson(v));
      });
    }
  }


  Land.fromFormJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalArea = json['totalArea'];
    cultivatedArea = json['cultivatedArea'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    farmer = json['farmer'] ;
    if (json['farmCoordinates'] != null) {
      farmCoordinates = <FarmCoordinates>[];
      json['farmCoordinates'].forEach((v) {
        farmCoordinates!.add(FarmCoordinates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['totalArea'] = totalArea;
    data['cultivatedArea'] = cultivatedArea;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    if (farmer != null) {
      data['farmer'] = farmer!.toJson();
    }
    if (farmCoordinates != null) {
      data['farmCoordinates'] =
          farmCoordinates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Farmer {
  String? id;
  String? name;

  Farmer({this.id, this.name});

  Farmer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
