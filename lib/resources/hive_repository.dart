import 'dart:convert';
import 'dart:io';

import 'package:digitalfarming/blocs/client/image_client.dart';
import 'package:digitalfarming/launch_setup.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/bin.dart';
import 'package:digitalfarming/models/catalogue.dart';
import 'package:digitalfarming/models/variety.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
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

  ImageClient? imageClient;

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
        'sowing',
        'bin',
        'procurement'
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

  Future<List<Location>> findAllTaluks() async {
    if (boxCollection != null) {
      final talukBox = await boxCollection?.openBox<Map>('taluk');
      Map<String, Map>? taluks = await talukBox?.getAllValues();
      int len = taluks?.length ?? 0;
      List<Location> talukList = [];
      for (var i = 0; i < len; i++) {
        talukList.add(Location.fromJson(taluks!.values.elementAt(i)));
      }

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

  Future<List<Variety>> getGradesByVariety({required String cropId}) async {
    if (boxCollection != null) {
      final varietyBox = await boxCollection?.openBox<Map>('grades');
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

  Future<List<Catalogue>> getCatalogues() async {
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


  Future saveProcurement(String procurement, String tempProcurementId) async {
    if (boxCollection != null) {
      final farmerBox = await boxCollection?.openBox<Map>('procurement');
      Map valueMap = json.decode(procurement);
      await farmerBox?.put(tempProcurementId, valueMap);
    }
  }


  Future saveBin(String binObj, String tempBinId) async {
    if (boxCollection != null) {
      final binBox = await boxCollection?.openBox<Map>('bin');
      Map valueMap = json.decode(binObj);
      await binBox?.put(tempBinId, valueMap);
    }
  }

  Future saveSowing(String sowing, String tempSowingId) async {
    if (boxCollection != null) {
      final sowingBox = await boxCollection?.openBox<Map>('sowing');
      Map valueMap = json.decode(sowing);
      await sowingBox?.put(tempSowingId, valueMap);
    }
  }

  Future saveLand(String farm, String tempFarmId) async {
    if (boxCollection != null) {
      final farmerBox = await boxCollection?.openBox<Map>('farm');
      Map valueMap = json.decode(farm);
      await farmerBox?.put(tempFarmId, valueMap);
    }
  }

  Future<Map?> getFarmers() async {
    if (boxCollection != null) {
      imageClient = ImageClient();
      final farmerBox = await boxCollection?.openBox<Map>('farmer');
      List<String> availableKeys = [];
      Map<String, Map>? farmers = await farmerBox?.getAllValues();

      for (MapEntry farmer in farmers!.entries) {
        if (farmer.value['isSynced'] ?? false) {
          availableKeys.add(farmer.key);
        }

        if (farmer.value['imagePath'] != null &&
            farmer.value['imagePath'] != '') {
          Result<String> imageResult = await imageClient!
              .savePhoto(photo: XFile(farmer.value['imagePath']));
          farmer.value['image'] = imageResult.data;
        }

        if (farmer.value['farmImagePath'] != null &&
            farmer.value['farmImagePath'] != '') {
          Result<String> imageResult = await imageClient!
              .savePhoto(photo: XFile(farmer.value['farmImagePath']));
          farmer.value['farmImage'] = imageResult.data;
        }
      }

      for (String key in availableKeys) {
        farmers.remove(key);
      }

      return farmers;
    }
    return {};
  }

  Future<Map?> getSowings() async {
    if (boxCollection != null) {
      imageClient = ImageClient();
      final farmerBox = await boxCollection?.openBox<Map>('sowing');
      List<String> availableKeys = [];
      Map<String, Map>? sowings = await farmerBox?.getAllValues();

      for (MapEntry farmer in sowings!.entries) {
        if (farmer.value['isSynced'] ?? false) {
          availableKeys.add(farmer.key);
        }

        if (farmer.value['imagePath'] != null &&
            farmer.value['imagePath'] != '') {
          Result<String> imageResult = await imageClient!
              .savePhoto(photo: XFile(farmer.value['imagePath']));
          farmer.value['image'] = imageResult.data;
        }
      }

      for (String key in availableKeys) {
        sowings.remove(key);
      }

      return sowings;
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

  Future<List<Bin>> getBins() async {
    if (boxCollection != null) {
      final binBox = await boxCollection?.openBox<Map>('bin');
      Map<String, Map>? bins = await binBox?.getAllValues();

      int len = bins?.length ?? 0;
      List<Bin> binsList = [];

      for (var i = 0; i < len; i++) {
        binsList.add(Bin.fromJson(bins!.values.elementAt(i)));
      }

      return binsList;
    }
    return [];
  }

  Future<Map?> fetchBins() async {
    if (boxCollection != null) {
      imageClient = ImageClient();
      final farmerBox = await boxCollection?.openBox<Map>('bin');
      List<String> availableKeys = [];
      Map<String, Map>? bins = await farmerBox?.getAllValues();

      for (MapEntry farmer in bins!.entries) {
        if (farmer.value['isSynced'] ?? false) {
          availableKeys.add(farmer.key);
        }
      }

      for (String key in availableKeys) {
        bins.remove(key);
      }

      return bins;
    }
    return {};
  }


  Future<Map?> fetchProcurements() async {
    if (boxCollection != null) {
      final farmerBox = await boxCollection?.openBox<Map>('procurement');
      List<String> availableKeys = [];
      Map<String, Map>? procurements = await farmerBox?.getAllValues();

      for (MapEntry procurement in procurements!.entries) {
        if (procurement.value['isSynced'] ?? false) {
          availableKeys.add(procurement.key);
        }
      }

      for (String key in availableKeys) {
        procurements.remove(key);
      }

      return procurements;
    }
    return {};
  }

  Future<Map?> delete() async {
    if (boxCollection != null) {
      print("Deleted Records !!");
      await boxCollection!.deleteFromDisk();
    }
  }

  Future<void> syncFarmerData(List farmerData) async {
    if (boxCollection != null) {
      final farmerBox = await boxCollection?.openBox<Map>('farmer');
      for (dynamic farmer in farmerData) {
        await farmerBox?.put(farmer['tempFarmerId'] ?? '', farmer);
      }
    }
  }

  Future<void> syncSowingData(List sowingData) async {
    if (boxCollection != null) {
      final farmerBox = await boxCollection?.openBox<Map>('sowing');
      for (dynamic sowing in sowingData) {
        await farmerBox?.put(sowing['tempSowingId'] ?? '', sowing);
      }
    }
  }

  Future<void> syncBinData(List data) async {
    if (boxCollection != null) {
      final binBox = await boxCollection?.openBox<Map>('bin');
      for (dynamic bin in data) {
        await binBox?.put(bin['tempBinId'] ?? '', bin);
      }
    }
  }

  Future<void> syncProcurementData(List data) async {
    if (boxCollection != null) {
      final procurementBox = await boxCollection?.openBox<Map>('procurement');
      for (dynamic procurement in data) {
        await procurementBox?.put(procurement['tempProcurementId'] ?? '', procurement);
      }
    }
  }

}
