import 'package:digitalfarming/blocs/client/taluk_client.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/location.dart';
import 'package:digitalfarming/resources/result.dart';

class TalukRepository {
  TalukRepository({TalukClient? client}) {
    _client = client ?? TalukClient();
  }

  TalukClient _client = TalukClient();

  Future<Result<List<Location>>> getTaluks({required String districtId}) async {
    return await _client.getTaluks(districtId: districtId);
  }

  Future<Result<List<Basic>>> getAllTaluks() async {
    return await _client.getAllTaluks();
  }
}
