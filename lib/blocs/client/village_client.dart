import 'package:digitalfarming/models/location.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';

class VillageClient {
  VillageClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getVillagePath = '/village/by-taluk?taluk=';

  ApiBaseHelper? _helper;

  Future<Result<List<Location>>> getVillages({required String talukId}) async {
    HiveRepository hiveRepository = HiveRepository();
    List<Location> responseList =
    await hiveRepository.findAllVillage(talukId: talukId);
    return Result.completed(responseList);
  }

}
