import 'dart:convert';

import 'package:digitalfarming/models/land.dart';
import 'package:digitalfarming/models/pagination.dart';
import 'package:digitalfarming/models/table_response.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/ui_state.dart';

class LandClient {
  LandClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const saveLandPath = '/land/save';
  static const getLandPath = '/farmer/';

  ApiBaseHelper? _helper;

  Future<Result<String>> saveLand({required Land land}) async {
    try {
      await _helper?.post(true, saveLandPath, land);
      return Result.completed(UIState.completed.name);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }


  Future<Result<TableResponse>> getLands({required Pagination pagination}) async {
    try {
      final String response = await _helper?.post(true, getLandPath, pagination);
      TableResponse tableResponse = TableResponse.fromJson(json.decode(response));
      return Result.completed(tableResponse);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }


}
