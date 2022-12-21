import '../../models/bin_scr.dart';
import '../../resources/result.dart';
import '../client/binscr_client.dart';

class BinRepository {
  BinRepository({BinClient? client}) {
    _client = client ?? BinClient();
  }
  BinClient _client = BinClient();

  Future<Result<String>> saveBin({required Bin binScr}) async {
    return await _client.saveBin(binScr: binScr);
  }
}
