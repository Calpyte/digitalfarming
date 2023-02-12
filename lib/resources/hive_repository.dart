import 'dart:convert';
import 'dart:io';

import 'package:digitalfarming/launch_setup.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/catalogue.dart';
import 'package:digitalfarming/models/variety.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/location.dart';

class HiveRepository implements LaunchSetupMember {
  factory HiveRepository() {
    return _singleton;
  }

  HiveRepository._internal() {
    if (boxCollection == null) {
      getCollection().then((collection) => {boxCollection = collection});
    }
  }

  static final HiveRepository _singleton = HiveRepository._internal();

  BoxCollection? boxCollection;
  Set<String> boxNames = {};

  @override
  Future<void> load() {
    return getCollection();
  }

  Future<BoxCollection?> getCollection() async {
    if (boxCollection != null) {
      return boxCollection;
    }

    WidgetsFlutterBinding.ensureInitialized();

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    BoxCollection collection = await BoxCollection.open(
      'farmAngel', // Name of your database
      {
        'country',
        'state',
        'district',
        'taluk',
        'village',
        'season',
        'groups',
        'crops',
        'varieties',
        'catalogue',
        'farmer',
        'farm',
        'sowing'
      }, // Names of your boxes
      path:
          tempPath, // Path where to store your boxes (Only used in Flutter / Dart IO)
    );

    return collection;
  }

  Future<List<Location>> getCountry() async {
    if (boxCollection != null) {
      final countryBox = await boxCollection?.openBox<Map>('country');
      Map<String, Map>? countries = await countryBox?.getAllValues();

      int len = countries?.length ?? 0;
      List<Location> countriesList = [];

      for (var i = 0; i < len; i++) {
        countriesList.add(Location.fromJson(countries!.values.elementAt(i)));
      }

      return countriesList;
    }
    return [];
  }

  Future<List<Location>> findAllState({required String countryId}) async {
    if (boxCollection != null) {
      final stateBox = await boxCollection?.openBox<Map>('state');
      Map<String, Map>? states = await stateBox?.getAllValues();
      int len = states?.length ?? 0;
      List<Location> statesList = [];

      for (var i = 0; i < len; i++) {
        statesList.add(Location.fromJson(states!.values.elementAt(i)));
      }

      statesList.where((element) => element.country?.id == countryId);
      return statesList;
    }
    return [];
  }

  Future<List<Location>> findAllDistrict({required String stateId}) async {
    if (boxCollection != null) {
      final districtBox = await boxCollection?.openBox<Map>('district');
      Map<String, Map>? districts = await districtBox?.getAllValues();
      int len = districts?.length ?? 0;
      List<Location> districtList = [];

      for (var i = 0; i < len; i++) {
        districtList.add(Location.fromJson(districts!.values.elementAt(i)));
      }

      districtList.where((element) => element.state?.id == stateId);
      return districtList;
    }
    return [];
  }

  Future<List<Location>> findAllTaluk({required String district}) async {
    if (boxCollection != null) {
      final talukBox = await boxCollection?.openBox<Map>('taluk');
      Map<String, Map>? taluks = await talukBox?.getAllValues();
      int len = taluks?.length ?? 0;
      List<Location> talukList = [];

      for (var i = 0; i < len; i++) {
        talukList.add(Location.fromJson(taluks!.values.elementAt(i)));
      }

      talukList.where((element) => element.district?.id == district);
      return talukList;
    }
    return [];
  }

  Future<List<Location>> findAllVillage({required String talukId}) async {
    if (boxCollection != null) {
      final villageBox = await boxCollection?.openBox<Map>('village');
      Map<String, Map>? villages = await villageBox?.getAllValues();
      int len = villages?.length ?? 0;
      List<Location> districtList = [];

      for (var i = 0; i < len; i++) {
        districtList.add(Location.fromJson(villages!.values.elementAt(i)));
      }

      districtList.where((element) => element.taluk?.id == talukId);
      return districtList;
    }
    return [];
  }

  Future<List<Basic>> getSeasons() async {
    if (boxCollection != null) {
      final seasonBox = await boxCollection?.openBox<Map>('season');
      Map<String, Map>? seasons = await seasonBox?.getAllValues();
      int len = seasons?.length ?? 0;
      List<Basic> seasonList = [];

      for (var i = 0; i < len; i++) {
        seasonList.add(Basic.fromJson(seasons!.values.elementAt(i)));
      }

      return seasonList;
    }
    return [];
  }

  Future<List<Basic>> getCrops() async {
    if (boxCollection != null) {
      final cropBox = await boxCollection?.openBox<Map>('crops');
      Map<String, Map>? crops = await cropBox?.getAllValues();
      int len = crops?.length ?? 0;
      List<Basic> cropList = [];
      for (var i = 0; i < len; i++) {
        cropList.add(Basic.fromJson(crops!.values.elementAt(i)));
      }
      return cropList;
    }
    return [];
  }

  Future<List<Variety>> getVarietiesByCrop({required String cropId}) async {
    if (boxCollection != null) {
      final varietyBox = await boxCollection?.openBox<Map>('varieties');
      Map<String, Map>? varieties = await varietyBox?.getAllValues();
      int len = varieties?.length ?? 0;
      List<Variety> varietyList = [];

      for (var i = 0; i < len; i++) {
        varietyList.add(Variety.fromJson(varieties!.values.elementAt(i)));
      }
      varietyList.where((element) => element.crop?.id == cropId);
      return varietyList;
    }
    return [];
  }

  Future<List<Catalogue>> getCatalogueByType() async {
    if (boxCollection != null) {
      final catalogueBox = await boxCollection?.openBox<Map>('catalogue');
      Map<String, Map>? catalogues = await catalogueBox?.getAllValues();
      int len = catalogues?.length ?? 0;
      List<Catalogue> catalogueList = [];

      for (var i = 0; i < len; i++) {
        catalogueList.add(Catalogue.fromJson(catalogues!.values.elementAt(i)));
      }

      return catalogueList;
    }
    return [];
  }

  Future<List<Basic>> getGroups() async {
    if (boxCollection != null) {
      final groupBox = await boxCollection?.openBox<Map>('groups');
      Map<String, Map>? groups = await groupBox?.getAllValues();

      int len = groups?.length ?? 0;
      List<Basic> groupList = [];

      for (var i = 0; i < len; i++) {
        groupList.add(Basic.fromJson(groups!.values.elementAt(i)));
      }

      return groupList;
    }
    return [];
  }

  Future saveFarmer(String farmer, String tempFarmerId) async {
    if (boxCollection != null) {
      final farmerBox = await boxCollection?.openBox<Map>('farmer');
      Map valueMap = json.decode(farmer);
      await farmerBox?.put(tempFarmerId, valueMap);
    }
  }

  Future<Map?> getFarmers() async {
    if (boxCollection != null) {
      final farmerBox = await boxCollection?.openBox<Map>('farmer');
      List<String> availableKeys = [];
      Map<String, Map>? farmers = await farmerBox?.getAllValues();

      for(MapEntry farmer in farmers!.entries){
        if(farmer.value['isSynced'] ?? false){
          availableKeys.add(farmer.key);
        }
      }

      for(String key in availableKeys){
        farmers.remove(key);
      }

      return farmers;
    }
    return {};
  }

  Future<Map?> getOfflineFarmers() async {
    if (boxCollection != null) {
      final farmerBox = await boxCollection?.openBox<Map>('farmer');
      Map<String, Map>? farmers = await farmerBox?.getAllValues();
      return farmers;
    }
    return {};
  }

  Future<Map?> delete() async {
    if (boxCollection != null) {
      await boxCollection!.deleteFromDisk();
    }
  }

  Future<void> syncFarmerData(List farmerData) async {
    if (boxCollection != null) {
      final farmerBox = await boxCollection?.openBox<Map>('farmer');
      for(dynamic farmer in farmerData){
        await farmerBox?.put(farmer['tempFarmerId'] ?? '', farmer);
      }
    }
  }
}
