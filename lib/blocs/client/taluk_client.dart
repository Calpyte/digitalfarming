import 'dart:convert';

import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/country.dart';
import 'package:digitalfarming/models/location.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class TalukClient {
  TalukClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getTalukPath = '/taluk/by-district?district=';

  static const getAllTalukPath = '/taluk/taluks';

  ApiBaseHelper? _helper;

  Future<Result<List<Location>>> getTaluks({required String districtId}) async {
    HiveRepository hiveRepository = HiveRepository();
    List<Location> responseList =
    await hiveRepository.findAllTaluk(district: districtId);
    return Result.completed(responseList);
  }

  Future<Result<List<Location>>> getAllTaluks() async {
    HiveRepository hiveRepository = HiveRepository();
    List<Location> responseList =
    await hiveRepository.findAllTaluks();
    return Result.completed(responseList);
  }
}
