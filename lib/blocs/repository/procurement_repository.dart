import 'package:digitalfarming/blocs/client/district_client.dart';
import 'package:digitalfarming/blocs/client/farmer_client.dart';
import 'package:digitalfarming/blocs/client/group_client.dart';
import 'package:digitalfarming/blocs/client/procurement_client.dart';
import 'package:digitalfarming/blocs/client/taluk_client.dart';
import 'package:digitalfarming/blocs/client/village_client.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/farmer.dart';
import 'package:digitalfarming/models/pagination.dart';
import 'package:digitalfarming/models/procurement.dart';
import 'package:digitalfarming/models/search_criteria.dart';
import 'package:digitalfarming/models/table_response.dart';
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
