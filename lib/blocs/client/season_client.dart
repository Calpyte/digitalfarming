import 'dart:convert';

import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class SeasonClient {
  SeasonClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getGroupPath = '/group/groups';

  ApiBaseHelper? _helper;

  Future<Result<List<Basic>>> getSeasons() async {
    HiveRepository hiveRepository = HiveRepository();
    return Result.completed(await hiveRepository.getSeasons());
  }
}
