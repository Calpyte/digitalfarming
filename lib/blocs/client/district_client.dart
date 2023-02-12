import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';

import '../../models/location.dart';

class DistrictClient {
  DistrictClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getDistrictPath = '/district/by-state?state=';

  ApiBaseHelper? _helper;

  Future<Result<List<Location>>> getDistricts({required String stateId}) async {
    HiveRepository hiveRepository = HiveRepository();
    List<Location> responseList =
    await hiveRepository.findAllDistrict(stateId: stateId);
    return Result.completed(responseList);
  }
}
