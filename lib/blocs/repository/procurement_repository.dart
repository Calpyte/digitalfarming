import 'package:digitalfarming/blocs/client/procurement_client.dart';
import 'package:digitalfarming/models/procurement.dart';
import 'package:digitalfarming/resources/result.dart';

class ProcurementRepository {
  ProcurementRepository({ProcurementClient? client}) {
    _client = client ?? ProcurementClient();
  }

  ProcurementClient _client = ProcurementClient();

  Future<Result<String>> saveProcurement({required Procurement procurement}) async {
    return await _client.saveProcurement(procurement: procurement);
  }
}
