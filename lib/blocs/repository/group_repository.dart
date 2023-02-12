import 'package:digitalfarming/blocs/client/group_client.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/result.dart';

class GroupRepository {
  GroupRepository({GroupClient? client}) {
    _client = client ?? GroupClient();
  }

  GroupClient _client = GroupClient();

  Future<Result<List<Basic>>> getGroups() async {
    return await _client.getGroups();
  }
}
