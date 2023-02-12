import 'package:digitalfarming/models/Basic.dart';

class Variety {
  String? id;
  String? name;
  Basic? crop;

  Variety({this.id, this.name, this.crop});

  Variety.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    crop = json['crop'] != null ?  Basic.fromJson(json['crop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (crop != null) {
      data['crop'] = crop!.toJson();
    }
    return data;
  }
}