import 'dart:convert';

import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';

import '../../utils/constants.dart';

class GradeClient {
  GradeClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getgradePath = '/grade/by-crop?crop=';

  ApiBaseHelper? _helper;

  Future<Result<List<Basic>>> getGrades({required String varietyId}) async {
    try {
      String responseStr = await _helper?.get(getgradePath + varietyId);
      List<dynamic> response = json.decode(responseStr);
      List<Basic> gradeList = [];
      for (var i = 0; i < response.length; i++) {
        gradeList.add(Basic.fromJson(response[i]));
      }
      return Result.completed(gradeList);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }
}