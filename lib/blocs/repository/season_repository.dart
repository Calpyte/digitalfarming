import 'package:digitalfarming/blocs/client/group_client.dart';
import 'package:digitalfarming/blocs/client/season_client.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/result.dart';

class SeasonRepository {
  SeasonRepository({SeasonClient? client}) {
    _client = client ?? SeasonClient();
  }

  SeasonClient _client = SeasonClient();

  Future<Result<List<Basic>>> getSeasons() async {
    return await _client.getSeasons();
  }

}
