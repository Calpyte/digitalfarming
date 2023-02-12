import 'package:digitalfarming/models/location.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';

class CountryClient {
  CountryClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const getCountryPath = '/country/countries';

  ApiBaseHelper? _helper;

  Future<Result<List<Location>>> getCountries() async {
    HiveRepository hiveRepository = HiveRepository();
    return Result.completed(await hiveRepository.getCountry());
  }
}
