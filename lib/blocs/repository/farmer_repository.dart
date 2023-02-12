import 'package:digitalfarming/blocs/client/farmer_client.dart';
import 'package:digitalfarming/models/farmer.dart';
import 'package:digitalfarming/models/pagination.dart';
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


  Future<Result<String>> saveOfflineFarmer() async {
    return await _client.saveOfflineFarmer();
  }

  Future<Result<TableResponse>> getFarmer(Pagination pagination) async {
    return await _client.getFarmers(pagination: pagination);
  }

  Future<Result<List>> getOfflineFarmers() async {
    return await _client.getOfflineFarmers();
  }


}
