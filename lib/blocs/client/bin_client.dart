import 'dart:convert';

import 'package:digitalfarming/models/bin.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class BinClient {
  BinClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }
  static const getProductPath = '/bin/bins';

  ApiBaseHelper? _helper;

  Future<Result<List<Bin>>> getBins() async {
    try {
      String responseStr = await _helper?.get(getProductPath);
      List<dynamic> response = json.decode(responseStr);
      List<Bin> responseList = [];
      for (var i = 0; i < response.length; i++) {
        responseList.add(Bin.fromJson(response[i]));
      }
      return Result.completed(responseList);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }
}
