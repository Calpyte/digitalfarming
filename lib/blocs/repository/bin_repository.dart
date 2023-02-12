import 'package:digitalfarming/blocs/client/bin_client.dart';
import 'package:digitalfarming/models/bin.dart';
import 'package:digitalfarming/resources/result.dart';

class BinRepository {
  BinRepository({BinClient? client}) {
    _client = client ?? BinClient();
  }

  BinClient _client = BinClient();

  Future<Result<String>> saveBin({required Bin bin}) async {
    return await _client.saveBin(bin: bin);
  }

  Future<Result<List<Bin>>> getBins() async {
    return await _client.getBins();
  }

  Future<Result> deleteBin({required String id}) async {
    return await _client.deleteBin(id: id);
  }
}
