import 'dart:async';

import 'package:digitalfarming/blocs/repository/district_repository.dart';
import 'package:digitalfarming/blocs/repository/farmer_repository.dart';
import 'package:digitalfarming/blocs/repository/group_repository.dart';
import 'package:digitalfarming/blocs/repository/taluk_repository.dart';
import 'package:digitalfarming/blocs/repository/village_repository.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/farmer.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class FarmerBloc {
  final logger = AppLogger.get('FarmerBloc');
  final FarmerRepository _farmerRepository = FarmerRepository();

  final StreamController<Result> _farmerController = StreamController<Result>();

  StreamSink get farmerSink => _farmerController.sink;
  Stream<Result> get farmerStream => _farmerController.stream;

  Future<void> saveFarmer({required Farmer farmer}) async {
    farmerSink.add(Result.loading(Constants.LOADING));
    final Result<String> response =
        await _farmerRepository.saveFarmer(farmer: farmer);
    farmerSink.add(response);
  }

  void dispose() {
    _farmerController.close();
  }
}
