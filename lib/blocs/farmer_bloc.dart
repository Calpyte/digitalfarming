import 'dart:async';

import 'package:digitalfarming/blocs/repository/farmer_repository.dart';
import 'package:digitalfarming/models/farmer.dart';
import 'package:digitalfarming/models/pagination.dart';
import 'package:digitalfarming/models/search_criteria.dart';
import 'package:digitalfarming/models/table_response.dart';
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
    farmerSink.add(Result.completed(response));
  }

  Future<void> saveOfflineFarmer() async {
    farmerSink.add(Result.loading(Constants.LOADING));
    final Result<String> response = await _farmerRepository.saveOfflineFarmer();
    farmerSink.add(Result.completed(response));
  }

  Future<void> saveOfflineSowing() async {
    farmerSink.add(Result.loading(Constants.LOADING));
    final Result<String> response = await _farmerRepository.saveOfflineSowing();
    farmerSink.add(Result.completed(response));
  }

  Future<void> getOfflineFarmers() async {
    farmerSink.add(Result.loading(Constants.LOADING));
    final Result<List<dynamic>> response =
        await _farmerRepository.getOfflineFarmers();
    farmerSink.add(response);
  }

  Future<void> getFarmer(List<SearchCriteria> criterias) async {
    farmerSink.add(Result.loading(Constants.LOADING));
    Pagination pagination =
        Pagination(filter: criterias, pageNo: 1, pageSize: 10000);

    final Result<TableResponse> response =
        await _farmerRepository.getFarmer(pagination);

    farmerSink.add(response);
  }

  void dispose() {
    _farmerController.close();
  }
}
