import 'dart:convert';

import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/variety.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';

import '../../utils/constants.dart';

class VarietyClient {
  VarietyClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getvarietiesPath = '/variety/by-crop?id=';

  ApiBaseHelper? _helper;

  Future<Result<List<Variety>>> getVarieties({required String productId}) async {
    HiveRepository hiveRepository = HiveRepository();
    List<Variety> varities = await hiveRepository.getVarietiesByCrop(cropId: productId);
    return Result.completed(varities);
  }
}