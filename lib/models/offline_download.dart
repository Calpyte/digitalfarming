import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/location.dart';
import 'package:digitalfarming/models/variety.dart';

import 'catalogue.dart';

class OfflineDownload {
  List<Location>? countries;
  List<Location>? states;
  List<Location>? districts;
  List<Location>? taluks;
  List<Location>? villages;
  List<Basic>? seasons;
  List<Basic>? groups;
  List<Basic>? crops;
  List<Variety>? varieties;
  List<Catalogue>? catalogues;

  OfflineDownload(
      {this.countries,
        this.states,
        this.districts,
        this.taluks,
        this.villages,
        this.seasons,
        this.groups,
        this.crops,
        this.varieties,
        this.catalogues});

  OfflineDownload.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Location>[];
      json['countries'].forEach((v) {
        countries!.add(Location.fromJson(v));
      });
    }
    if (json['states'] != null) {
      states = <Location>[];
      json['states'].forEach((v) {
        states!.add(Location.fromJson(v));
      });
    }
    if (json['districts'] != null) {
      districts = <Location>[];
      json['districts'].forEach((v) {
        districts!.add(Location.fromJson(v));
      });
    }
    if (json['taluks'] != null) {
      taluks = <Location>[];
      json['taluks'].forEach((v) {
        taluks!.add(Location.fromJson(v));
      });
    }
    if (json['villages'] != null) {
      villages = <Location>[];
      json['villages'].forEach((v) {
        villages!.add(Location.fromJson(v));
      });
    }
    if (json['seasons'] != null) {
      seasons = <Basic>[];
      json['seasons'].forEach((v) {
        seasons!.add(Basic.fromJson(v));
      });
    }
    if (json['groups'] != null) {
      groups = <Basic>[];
      json['groups'].forEach((v) {
        groups!.add(Basic.fromJson(v));
      });
    }
    if (json['crops'] != null) {
      crops = <Basic>[];
      json['crops'].forEach((v) {
        crops!.add(Basic.fromJson(v));
      });
    }
    if (json['varieties'] != null) {
      varieties = <Variety>[];
      json['varieties'].forEach((v) {
        varieties!.add(Variety.fromJson(v));
      });
    }
    if (json['catalogues'] != null) {
      catalogues = <Catalogue>[];
      json['catalogues'].forEach((v) {
        catalogues!.add(Catalogue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (countries != null) {
      data['countries'] =countries!.map((v) => v.toJson()).toList();
    }
    if (states != null) {
      data['states'] =states!.map((v) => v.toJson()).toList();
    }
    if (districts != null) {
      data['districts'] =districts!.map((v) => v.toJson()).toList();
    }
    if (taluks != null) {
      data['taluks'] =taluks!.map((v) => v.toJson()).toList();
    }
    if (villages != null) {
      data['villages'] =villages!.map((v) => v.toJson()).toList();
    }
    if (seasons != null) {
      data['seasons'] =seasons!.map((v) => v.toJson()).toList();
    }
    if (groups != null) {
      data['groups'] =groups!.map((v) => v.toJson()).toList();
    }
    if (crops != null) {
      data['crops'] =crops!.map((v) => v.toJson()).toList();
    }
    if (varieties != null) {
      data['varieties'] =varieties!.map((v) => v.toJson()).toList();
    }
    if (catalogues != null) {
      data['catalogues'] =catalogues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}