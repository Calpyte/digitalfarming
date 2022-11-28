import 'dart:convert';

import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/country.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class VillageClient {
  VillageClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getVillagePath = '/village/by-taluk?taluk=';

  ApiBaseHelper? _helper;

  Future<Result<List<Basic>>> getVillages({required String talukId}) async {
    try {
      String responseStr = await _helper?.get(getVillagePath + talukId);
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
