import 'package:digitalfarming/blocs/client/country_client.dart';
import 'package:digitalfarming/models/country.dart';
import 'package:digitalfarming/resources/result.dart';

class CountryRepository {
  CountryRepository({CountryClient? client}) {
    _client = client ?? CountryClient();
  }

  CountryClient _client = CountryClient();

  Future<Result<List<Country>>> getCountries() async {
    return await _client.getCountries();
  }

}
