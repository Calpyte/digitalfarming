import 'package:digitalfarming/blocs/client/state_client.dart';
import 'package:digitalfarming/models/location.dart';
import 'package:digitalfarming/resources/result.dart';

class StateRepository {
  StateRepository({StateClient? client}) {
    _client = client ?? StateClient();
  }

  StateClient _client = StateClient();

  Future<Result<List<Location>>> getStates({required String countryId}) async {
    return await _client.getStates(countryId: countryId);
  }
}
