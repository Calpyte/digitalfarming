import 'dart:convert';

import 'package:digitalfarming/models/farmer.dart';
import 'package:digitalfarming/models/pagination.dart';
import 'package:digitalfarming/models/table_response.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/ui_state.dart';

class FarmerClient {
  FarmerClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const saveFarmerPath = '/farmer/save';
  static const getFarmerPath = '/farmer/';
  static const saveFarmerOfflinePath = '/farmer/offline-save';
  static const saveFarmCorpOfflinePath = '/farmCrop/offline-save';
  static const saveBinPath = '/bin/offline-save';
  static const saveProcurementPath = '/procurement/offline-save';

  ApiBaseHelper? _helper;

  Future<Result<String>> saveFarmer({required Farmer farmer}) async {
    try {
      await _helper?.post(true, saveFarmerPath, farmer);
      return Result.completed(UIState.completed.name);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }

  Future<Result<String>> saveOfflineFarmer() async {
    try {
      HiveRepository hiveRepository = HiveRepository();
      Map? farmer = await hiveRepository.getFarmers();
      await _helper?.post(true, saveFarmerOfflinePath, farmer);
      return Result.completed(UIState.completed.name);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }

  Future<Result<String>> saveOfflineSowing() async {
    try {
      HiveRepository hiveRepository = HiveRepository();
      Map? farmer = await hiveRepository.getSowings();
      await _helper?.post(true, saveFarmCorpOfflinePath, farmer);
      return Result.completed(UIState.completed.name);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }

  Future<Result<String>> saveBinProcessing() async {
    try {
      HiveRepository hiveRepository = HiveRepository();
      Map? farmer = await hiveRepository.fetchBins();
      await _helper?.post(true, saveBinPath, farmer);
      return Result.completed(UIState.completed.name);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }

  Future<Result<String>> saveProcurement() async {
    try {
      HiveRepository hiveRepository = HiveRepository();
      Map? farmer = await hiveRepository.fetchProcurements();
      await _helper?.post(true, saveProcurementPath, farmer);
      return Result.completed(UIState.completed.name);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }

  Future<Result<TableResponse>> getFarmers({required Pagination pagination}) async {
    try {
      final String response = await _helper?.post(true, getFarmerPath, pagination);
      TableResponse tableResponse = TableResponse.fromJson(json.decode(response));
      return Result.completed(tableResponse);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }

  Future<Result<List>> getOfflineFarmers() async {
    HiveRepository hiveRepository = HiveRepository();
    Map? farmerMap = await hiveRepository.getOfflineFarmers();
    List<dynamic> farmers = [];
    for (dynamic farmer in farmerMap!.values) {
      farmers.add(farmer);
    }
    return Result.completed(farmers);
  }

}
