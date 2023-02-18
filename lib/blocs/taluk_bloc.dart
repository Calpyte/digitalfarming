import 'dart:async';

import 'package:digitalfarming/blocs/repository/taluk_repository.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/location.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class TalukBloc {
  final logger = AppLogger.get('TalukBloc');
  final TalukRepository _talukRepository = TalukRepository();

  final StreamController<Result> _talukController =
      StreamController<Result>();

  StreamSink get talukSink => _talukController.sink;
  Stream<Result> get talukStream => _talukController.stream;

  Future<void> getTaluks({required String districtId}) async {
    talukSink.add(Result.loading(Constants.LOADING));
    final Result<List<Location>> response =
        await _talukRepository.getTaluks(districtId: districtId);
    talukSink.add(response);
  }

  Future<void> getAllTaluks() async {
    talukSink.add(Result.loading(Constants.LOADING));
    final Result<List<Location>> response = await _talukRepository.getAllTaluks();
    talukSink.add(response);
  }

  void dispose() {
    _talukController.close();
  }
}
