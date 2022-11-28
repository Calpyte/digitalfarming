import 'dart:async';

import 'package:digitalfarming/blocs/repository/district_repository.dart';
import 'package:digitalfarming/blocs/repository/taluk_repository.dart';
import 'package:digitalfarming/blocs/repository/village_repository.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class VillageBloc {
  final logger = AppLogger.get('VillageBloc');
  final VillageRepository _villageRepository = VillageRepository();

  final StreamController<Result> _villageController =
      StreamController<Result>();

  StreamSink get villageSink => _villageController.sink;
  Stream<Result> get villageStream => _villageController.stream;

  Future<void> getVillages({required String talukId}) async {
    villageSink.add(Result.loading(Constants.LOADING));
    final Result<List<Basic>> response =
        await _villageRepository.getVillages(districtId: talukId);
    villageSink.add(response);
  }

  void dispose() {
    _villageController.close();
  }
}
