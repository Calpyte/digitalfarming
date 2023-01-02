import 'dart:convert';

import 'package:digitalfarming/models/bin.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/ui_state.dart';

class BinClient {
  BinClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }
  static const getBinsPath = '/bin/bins';
  static const saveBinsPath = '/bin/save';

  ApiBaseHelper? _helper;


  Future<Result<String>> saveBin({required Bin bin}) async {
    try {
      await _helper?.post(true, saveBinsPath, bin);
      return Result.completed(UIState.completed.name);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }


  Future<Result<List<Bin>>> getBins() async {
    try {
      String responseStr = await _helper?.get(getBinsPath);
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
