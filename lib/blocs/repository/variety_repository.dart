import 'package:digitalfarming/blocs/client/variety_client.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/result.dart';

class VarietyRepository {
  VarietyRepository({VarietyClient? client}) {
    _client = client ?? VarietyClient();
  }

  VarietyClient _client = VarietyClient();

  Future<Result<List<Basic>>> getVarieties({required String productId}) async {
    return await _client.getVarieties(productId: productId);
  }
}
