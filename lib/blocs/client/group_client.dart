import 'dart:convert';

import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/country.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class GroupClient {
  GroupClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getGroupPath = '/group/groups';

  ApiBaseHelper? _helper;

  Future<Result<List<Basic>>> getGroups() async {
    try {
      String responseStr = await _helper?.get(getGroupPath);
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
