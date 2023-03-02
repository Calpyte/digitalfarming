import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/variety.dart';

class Procurement {
  String? id;
  Basic? farmer;
  Variety? variety;
  Basic? bin;
  Basic? season;
  String? totalWeight;
  String? price;
  double? latitude;
  double? longitude;

  Procurement(
      {this.id,
      this.farmer,
      this.variety,
      this.bin,
      this.season,
      this.totalWeight,
      this.price,
      this.latitude,
      this.longitude});

  Procurement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmer = json['farmer'] != null ? Basic?.fromJson(json['farmer']) : null;
    variety =
        json['variety'] != null ? Variety?.fromJson(json['variety']) : null;
    bin = json['bin'] != null ? Basic?.fromJson(json['bin']) : null;
    season = json['season'] != null ? Basic?.fromJson(json['season']) : null;
    totalWeight = json['totalWeight'];
    price = json['price'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Procurement.fromFormJson(Map<String, dynamic> json) {
    id = json['id'];
    farmer = json['farmer'];
    variety = json['variety'];
    bin = json['bin'];
    totalWeight = json['totalWeight'];
    price = json['price'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    season = json['season'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer'] = farmer!.toJson();
    data['variety'] = variety!.toJson();
    data['bin'] = bin?.toJson();
    data['season'] = season?.toJson();
    data['totalWeight'] = totalWeight;
    data['price'] = price;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
