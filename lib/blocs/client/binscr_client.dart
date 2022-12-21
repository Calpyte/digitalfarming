import 'package:digitalfarming/models/bin_scr.dart';

import '../../resources/api_base_helper.dart';
import '../../resources/api_exception.dart';
import '../../resources/result.dart';
import '../../utils/constants.dart';
import '../../utils/ui_state.dart';

class BinClient {
  BinClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const saveBinPath = '/bin/save';
  ApiBaseHelper? _helper;

  Future<Result<String>> saveBin({required Bin binScr}) async {
    try {
      await _helper?.post(true, saveBinPath, binScr);
      return Result.completed(UIState.completed.name);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }
}
