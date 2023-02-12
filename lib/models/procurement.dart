import 'package:digitalfarming/models/Basic.dart';

class Procurement {
  String? id;
  Basic? farmer;
  Basic? variety;
  Basic? grade;
  Basic? bin;
  String? totalWeight;
  String? price;
//  String? paymentType;
//  String? paymentMethod;
//  String? procurementDateStr;
  double? latitude;
  double? longitude;

  Procurement(
      {this.id,
      this.farmer,
      this.variety,
      this.grade,
      this.bin,
      this.totalWeight,
      this.price,
 //     this.paymentType,
  //    this.paymentMethod,
  //    this.procurementDateStr,
      this.latitude,
      this.longitude});

  Procurement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmer = json['farmer'] != null ? Basic?.fromJson(json['farmer']) : null;
    variety = json['variety'] != null ? Basic?.fromJson(json['variety']) : null;
    grade = json['grade'] != null ? Basic?.fromJson(json['grade']) : null;
    bin = json['bin'] != null ? Basic?.fromJson(json['bin']) : null;
    totalWeight = json['totalWeight'];
    price = json['price'];
 //   paymentType = json['paymentType'];
  //  paymentMethod = json['paymentMethod'];
 //   procurementDateStr = json['procurementDateStr'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }


  Procurement.fromFormJson(Map<String, dynamic> json) {
    id = json['id'];
    farmer = json['farmer'];
    variety = json['variety'];
    grade = json['grade'] ;
    bin = json['bin'];
    totalWeight = json['totalWeight'];
    price = json['price'];
 //   paymentType = json['paymentType'];
  //  paymentMethod = json['paymentMethod'];
  //  procurementDateStr = json['procurementDateStr'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer'] = farmer!.toJson();
    data['variety'] = variety!.toJson();
    data['grade'] = grade!.toJson();
    data['bin'] = bin!.toJson();
    data['totalWeight'] = totalWeight;
    data['price'] = price;
 //   data['paymentType'] = paymentType;
 //   data['paymentMethod'] = paymentMethod;
   // data['procurementDateStr'] = procurementDateStr;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
