import 'dart:convert';

import 'package:digitalfarming/models/bin.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/ui_state.dart';

class BinClient {
  BinClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }
  static const getBinsPath = '/bin/bins';
  static const saveBinsPath = '/bin/save';
  static const deleteBinsPath = '/bin/delete?id=';

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
    HiveRepository hiveRepository = HiveRepository();
    return Result.completed(await hiveRepository.getBins());
  }

  Future<Result> deleteBin({required String id}) async {
    try {
      String responseStr = await _helper?.get(deleteBinsPath+id);
      return Result.completed('deleted');
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }

}
