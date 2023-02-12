import 'dart:async';

import 'package:digitalfarming/blocs/repository/district_repository.dart';
import 'package:digitalfarming/models/location.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class DistrictBloc {
  final logger = AppLogger.get('StateBloc');
  final DistrictRepository _districtRepository = DistrictRepository();

  final StreamController<Result> _districtController =
      StreamController<Result>();

  StreamSink get districtSink => _districtController.sink;
  Stream<Result> get districtStream => _districtController.stream;

  Future<void> getDistricts({required String stateId}) async {
    districtSink.add(Result.loading(Constants.LOADING));
    final Result<List<Location>> response =
        await _districtRepository.getDistricts(stateId: stateId);
    districtSink.add(response);
  }

  void dispose() {
    _districtController.close();
  }
}
