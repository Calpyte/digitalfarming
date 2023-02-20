import 'dart:convert';

import 'package:digitalfarming/models/catalogue.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

import '../../models/Basic.dart';

class CatalogueClient {
  CatalogueClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  ApiBaseHelper? _helper;

  Future<Result<List<Catalogue>>> getCatalogues() async {
    HiveRepository hiveRepository = HiveRepository();
    return Result.completed(
      await hiveRepository.getCatalogues(),
    );
  }
}
