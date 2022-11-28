import 'package:digitalfarming/blocs/client/country_client.dart';
import 'package:digitalfarming/resources/result.dart';

import '../../models/Basic.dart';

class CountryRepository {
  CountryRepository({CountryClient? client}) {
    _client = client ?? CountryClient();
  }

  CountryClient _client = CountryClient();

  Future<Result<List<Basic>>> getCountries() async {
    return await _client.getCountries();
  }

}
