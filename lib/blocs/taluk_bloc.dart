import 'dart:async';

import 'package:digitalfarming/blocs/repository/district_repository.dart';
import 'package:digitalfarming/blocs/repository/taluk_repository.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class TalukBloc {
  final logger = AppLogger.get('TalukBloc');
  final TalukRepository _talukRepository = TalukRepository();

  final StreamController<Result> _districtController =
      StreamController<Result>();

  StreamSink get talukSink => _districtController.sink;
  Stream<Result> get talukStream => _districtController.stream;

  Future<void> getTaluks({required String districtId}) async {
    talukSink.add(Result.loading(Constants.LOADING));
    final Result<List<Basic>> response =
        await _talukRepository.getTaluks(districtId: districtId);
    talukSink.add(response);
  }

  void dispose() {
    _districtController.close();
  }
}
