import 'dart:convert';

import 'package:digitalfarming/models/country.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class StateClient {
  StateClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getStatePath = '/state/by-country?country=';

  ApiBaseHelper? _helper;

  Future<Result<List<Country>>> getStates({required String countryId}) async {
    try {
      String responseStr = await _helper?.get(getStatePath + countryId);
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
