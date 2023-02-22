import 'dart:io';

import 'package:digitalfarming/models/offline_download.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveProvider {
  Future<void> syncMasterData(OfflineDownload offlineDownload) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    final collection = await BoxCollection.open(
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
        'bin'
      }, // Names of your boxes
      path:
          tempPath, // Path where to store your boxes (Only used in Flutter / Dart IO)
    );

    final countryBox = await collection.openBox<Map>('country');
    offlineDownload.countries?.forEach((country) async {
      await countryBox.put(country.id ?? '', country.toJson());
    });

    final stateBox = await collection.openBox<Map>('state');
    offlineDownload.states?.forEach((state) async {
      await stateBox.put(state.id ?? '', state.toJson());
    });

    final districtBox = await collection.openBox<Map>('district');
    offlineDownload.districts?.forEach((district) async {
      await districtBox.put(district.id ?? '', district.toJson());
    });

    final talukBox = await collection.openBox<Map>('taluk');
    offlineDownload.taluks?.forEach((taluk) async {
      await talukBox.put(taluk.id ?? '', taluk.toJson());
    });

    final villageBox = await collection.openBox<Map>('village');
    offlineDownload.villages?.forEach((village) async {
      await villageBox.put(village.id ?? '', village.toJson());
    });

    final seasonBox = await collection.openBox<Map>('season');
    offlineDownload.seasons?.forEach((season) async {
      await seasonBox.put(season.id ?? '', season.toJson());
    });

    final groupBox = await collection.openBox<Map>('groups');
    offlineDownload.groups?.forEach((group) async {
      await groupBox.put(group.id ?? '', group.toJson());
    });

    final cropBox = await collection.openBox<Map>('crops');
    offlineDownload.crops?.forEach((crop) async {
      await cropBox.put(crop.id ?? '', crop.toJson());
    });

    final varietyBox = await collection.openBox<Map>('varieties');
    offlineDownload.varieties?.forEach((variety) async {
      await varietyBox.put(variety.id ?? '', variety.toJson());
    });

    final catalogueBox = await collection.openBox<Map>('catalogue');
    offlineDownload.catalogues?.forEach((catalogue) async {
      await catalogueBox.put(catalogue.id ?? '', catalogue.toJson());
    });
  }

}
