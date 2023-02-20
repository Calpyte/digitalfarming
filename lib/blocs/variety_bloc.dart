import 'dart:async';

import 'package:digitalfarming/blocs/repository/variety_repository.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/variety.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class VarietyBloc {
  final logger = AppLogger.get('VarietyBloc');
  final VarietyRepository _varietyRepository = VarietyRepository();

  final StreamController<Result> _varietyController =
      StreamController<Result>();

  StreamSink get varietySink => _varietyController.sink;
  Stream<Result> get varietyStream => _varietyController.stream;

  Future<void> getVarieties({required String productId}) async {
    varietySink.add(Result.loading(Constants.LOADING));
    final Result<List<Variety>> response =
        await _varietyRepository.getVarieties(productId: productId);
    varietySink.add(response);
  }

  void dispose() {
    _varietyController.close();
  }
}
