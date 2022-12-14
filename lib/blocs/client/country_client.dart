import 'dart:convert';

import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

import '../../models/Basic.dart';

class CountryClient {
  CountryClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getCountryPath = '/country/countries';

  ApiBaseHelper? _helper;

  Future<Result<List<Basic>>> getCountries() async {
    try {
      String responseStr = await _helper?.get(getCountryPath);
      List<dynamic> response = json.decode(responseStr);
      List<Basic> responseList = [];
      for (var i = 0; i < response.length; i++) {
        responseList.add(Basic.fromJson(response[i]));
      }
      return Result.completed(responseList);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }
}
