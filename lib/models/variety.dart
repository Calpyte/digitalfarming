import 'package:digitalfarming/models/Basic.dart';

class Variety {
  String? id;
  String? name;
  Basic? crop;
  Basic? variety;

  Variety({this.id, this.name, this.crop, this.variety});

  Variety.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    crop = json['crop'] != null ?  Basic.fromJson(json['crop']) : null;
    variety = json['variety'] != null ?  Basic.fromJson(json['variety']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (crop != null) {
      data['crop'] = crop!.toJson();
    }
    if (variety != null) {
      data['variety'] = variety!.toJson();
    }
    return data;
  }
}