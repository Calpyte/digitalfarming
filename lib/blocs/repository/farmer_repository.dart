import 'package:digitalfarming/blocs/client/district_client.dart';
import 'package:digitalfarming/blocs/client/farmer_client.dart';
import 'package:digitalfarming/blocs/client/group_client.dart';
import 'package:digitalfarming/blocs/client/taluk_client.dart';
import 'package:digitalfarming/blocs/client/village_client.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/farmer.dart';
import 'package:digitalfarming/models/pagination.dart';
import 'package:digitalfarming/models/search_criteria.dart';
import 'package:digitalfarming/models/table_response.dart';
import 'package:digitalfarming/resources/result.dart';

class FarmerRepository {
  FarmerRepository({FarmerClient? client}) {
    _client = client ?? FarmerClient();
  }

  FarmerClient _client = FarmerClient();

  Future<Result<String>> saveFarmer({required Farmer farmer}) async {
    return await _client.saveFarmer(farmer: farmer);
  }

  Future<Result<TableResponse>> getFarmer(Pagination pagination) async {
    return await _client.getFarmers(pagination: pagination);
  }

}
