import 'package:digitalfarming/blocs/client/village_client.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/result.dart';

class VillageRepository {
  VillageRepository({VillageClient? client}) {
    _client = client ?? VillageClient();
  }

  VillageClient _client = VillageClient();

  Future<Result<List<Basic>>> getVillages({required String districtId}) async {
    return await _client.getVillages(talukId: districtId);
  }
}
