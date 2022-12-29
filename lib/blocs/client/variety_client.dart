import 'dart:convert';

import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';

import '../../utils/constants.dart';

class VarietyClient {
  VarietyClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getvarietiesPath = '/variety/by-crop?id=';

  ApiBaseHelper? _helper;

  Future<Result<List<Basic>>> getVarieties({required String productId}) async {
    try {
      String responseStr = await _helper?.get(getvarietiesPath + productId);
      List<dynamic> response = json.decode(responseStr);
      List<Basic> varietyList = [];
      for (var i = 0; i < response.length; i++) {
        varietyList.add(Basic.fromJson(response[i]));
      }
      return Result.completed(varietyList);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }
}