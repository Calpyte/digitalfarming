import 'package:digitalfarming/blocs/client/bin_client.dart';
import 'package:digitalfarming/models/bin.dart';
import 'package:digitalfarming/resources/result.dart';

class BinRepository {
  BinRepository({BinClient? client}) {
    _client = client ?? BinClient();
  }

  BinClient _client = BinClient();

  Future<Result<List<Bin>>> getBins() async {
    return await _client.getBins();
  }
}
