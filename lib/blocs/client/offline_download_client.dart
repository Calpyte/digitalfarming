import 'dart:convert';

import 'package:digitalfarming/models/offline_download.dart';

import '../../resources/api_base_helper.dart';
import '../../resources/api_exception.dart';
import '../../resources/result.dart';
import '../../utils/constants.dart';

class OfflineDownloadClient {
  OfflineDownloadClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }
  static const getOfflineData = '/cache?lastSyncedTime=0';
  static const getFarmerDataPath = '/farmer/farmers?lastSyncedTime=0';
  static const getFarmCorpDataPath = '/farmCrop/farm-crops?lastSyncedTime=0';
  static const getBinDataPath = '/bin/bins?lastSyncedTime=0';

  ApiBaseHelper? _helper;

  Future<Result<OfflineDownload>> getMasterData() async {
    try {
      String responseStr = await _helper?.get(getOfflineData);
      OfflineDownload offlineDownload = OfflineDownload.fromJson(json.decode(responseStr));
      return Result.completed(offlineDownload);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }


  Future<Result<dynamic>> getFarmerData() async {
    try {
      String responseStr = await _helper?.get(getFarmerDataPath);
      return Result.completed(json.decode(responseStr));
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }

  Future<Result<dynamic>> getSowingData() async {
    try {
      String responseStr = await _helper?.get(getFarmCorpDataPath);
      return Result.completed(json.decode(responseStr));
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }

  Future<Result<dynamic>> getBinData() async {
    try {
      String responseStr = await _helper?.get(getBinDataPath);
      return Result.completed(json.decode(responseStr));
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }

}