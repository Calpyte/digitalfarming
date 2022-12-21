import 'dart:convert';

import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/country.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class DistrictClient {
  DistrictClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getDistrictPath = '/district/by-state?state=';

  ApiBaseHelper? _helper;

  Future<Result<List<Basic>>> getDistricts({required String stateId}) async {
    try {
      String responseStr = await _helper?.get(getDistrictPath + stateId);
      List<dynamic> response = json.decode(responseStr);
      List<Country> responseList = [];
      for (var i = 0; i < response.length; i++) {
        responseList.add(Country.fromJson(response[i]));
      }
      return Result.completed(responseList);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }
}
