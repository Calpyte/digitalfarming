import 'package:digitalfarming/blocs/client/land_client.dart';
import 'package:digitalfarming/models/land.dart';
import 'package:digitalfarming/models/pagination.dart';
import 'package:digitalfarming/models/table_response.dart';
import 'package:digitalfarming/resources/result.dart';

class LandRepository {
  LandRepository({LandClient? client}) {
    _client = client ?? LandClient();
  }

  LandClient _client = LandClient();

  Future<Result<String>> saveLand({required Land land}) async {
    return await _client.saveLand(land: land);
  }

  Future<Result<TableResponse>> getLands(Pagination pagination) async {
    return await _client.getLands(pagination: pagination);
  }

}
