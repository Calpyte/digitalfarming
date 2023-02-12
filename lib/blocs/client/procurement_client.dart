import 'package:digitalfarming/models/procurement.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/ui_state.dart';

class ProcurementClient {
  ProcurementClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const saveProcurementPath = '/procurement/save';

  ApiBaseHelper? _helper;

  Future<Result<String>> saveProcurement({required Procurement procurement}) async {
    try {
      await _helper?.post(true, saveProcurementPath, procurement);
      return Result.completed(UIState.completed.name);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }

}
