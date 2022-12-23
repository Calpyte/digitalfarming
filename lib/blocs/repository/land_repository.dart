import 'package:digitalfarming/blocs/client/district_client.dart';
import 'package:digitalfarming/blocs/client/farmer_client.dart';
import 'package:digitalfarming/blocs/client/group_client.dart';
import 'package:digitalfarming/blocs/client/land_client.dart';
import 'package:digitalfarming/blocs/client/taluk_client.dart';
import 'package:digitalfarming/blocs/client/village_client.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/farmer.dart';
import 'package:digitalfarming/models/land.dart';
import 'package:digitalfarming/models/pagination.dart';
import 'package:digitalfarming/models/search_criteria.dart';
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
