import 'package:digitalfarming/models/location.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';

class StateClient {
  StateClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getStatePath = '/state/by-country?country=';

  ApiBaseHelper? _helper;

  Future<Result<List<Location>>> getStates({required String countryId}) async {
    HiveRepository hiveRepository = HiveRepository();
    List<Location> responseList =
    await hiveRepository.findAllState(countryId: countryId);
    return Result.completed(responseList);
  }
}
