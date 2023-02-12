import 'package:digitalfarming/blocs/client/district_client.dart';
import 'package:digitalfarming/models/location.dart';
import 'package:digitalfarming/resources/result.dart';

class DistrictRepository {
  DistrictRepository({DistrictClient? client}) {
    _client = client ?? DistrictClient();
  }

  DistrictClient _client = DistrictClient();

  Future<Result<List<Location>>> getDistricts({required String stateId}) async {
    return await _client.getDistricts(stateId: stateId);
  }
}
