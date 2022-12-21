import 'package:digitalfarming/models/Basic.dart';

class TableResponse {
  int? draw;
  int? recordsTotal;
  int? recordsFiltered;
  List<Basic>? data;

  TableResponse({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.data,
  });

  TableResponse.fromJson(Map<String, dynamic> json) {
    draw = json['draw'];
    recordsTotal = json['recordsTotal'];
    recordsFiltered = json['recordsFiltered'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Basic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['draw'] = draw;
    data['recordsTotal'] = recordsTotal;
    data['recordsFiltered'] = recordsFiltered;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
