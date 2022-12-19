import 'dart:convert';

import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/country.dart';
import 'package:digitalfarming/models/farmer.dart';
import 'package:digitalfarming/models/pagination.dart';
import 'package:digitalfarming/models/table_response.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/ui_state.dart';

class FarmerClient {
  FarmerClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const saveFarmerPath = '/farmer/save';
  static const getFarmerPath = '/farmer/';

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


}
