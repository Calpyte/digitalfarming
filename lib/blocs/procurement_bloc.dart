import 'dart:async';

import 'package:digitalfarming/blocs/repository/procurement_repository.dart';
import 'package:digitalfarming/models/procurement.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class ProcurementBloc {
  final logger = AppLogger.get('ProcurementBloc');
  final ProcurementRepository _procurementRepository = ProcurementRepository();

  final StreamController<Result> _procurementController = StreamController<Result>();

  StreamSink get procurementSink => _procurementController.sink;
  Stream<Result> get procurementStream => _procurementController.stream;

  Future<void> saveProcurement({required Procurement procurement}) async {
    procurementSink.add(Result.loading(Constants.LOADING));
    final Result<String> response =
        await _procurementRepository.saveProcurement(procurement: procurement);
    procurementSink.add(Result.completed(response));
  }
}
