import 'dart:async';

import 'package:digitalfarming/blocs/repository/state_repository.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class StateBloc {
  final logger = AppLogger.get('StateBloc');
  final StateRepository _stateRepository = StateRepository();

  final StreamController<Result> _stateController = StreamController<Result>();

  StreamSink get stateSink => _stateController.sink;
  Stream<Result> get stateStream => _stateController.stream;


  Future<void> getStates({required String countryId}) async {
    stateSink.add(Result.loading(Constants.LOADING));
    final Result<List<Basic>> response =
    await _stateRepository.getStates(countryId: countryId);
    stateSink.add(response);
  }

  void dispose() {
    _stateController.close();
  }

}