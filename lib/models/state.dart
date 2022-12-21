import 'package:digitalfarming/models/Basic.dart';

import 'Country.dart';

class State extends Basic {
  State({
    this.country,
  });

  State.fromJson(dynamic json) {
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
  }
  Country? country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (country != null) {
      map['country'] = country!.toJson();
    }
    return map;
  }
}
