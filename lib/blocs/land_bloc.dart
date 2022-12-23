import 'dart:async';

import 'package:digitalfarming/blocs/repository/district_repository.dart';
import 'package:digitalfarming/blocs/repository/farmer_repository.dart';
import 'package:digitalfarming/blocs/repository/group_repository.dart';
import 'package:digitalfarming/blocs/repository/land_repository.dart';
import 'package:digitalfarming/blocs/repository/taluk_repository.dart';
import 'package:digitalfarming/blocs/repository/village_repository.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/farmer.dart';
import 'package:digitalfarming/models/land.dart';
import 'package:digitalfarming/models/pagination.dart';
import 'package:digitalfarming/models/search_criteria.dart';
import 'package:digitalfarming/models/table_response.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class LandBloc {
  final logger = AppLogger.get('FarmerBloc');
  final LandRepository _landRepository = LandRepository();

  final StreamController<Result> _landController = StreamController<Result>();

  StreamSink get landSink => _landController.sink;
  Stream<Result> get landStream => _landController.stream;

  Future<void> saveLand({required Land land}) async {
    landSink.add(Result.loading(Constants.LOADING));
    final Result<String> response =
        await _landRepository.saveLand(land: land);
    landSink.add(Result.completed(response));
  }

  Future<void> getLands(List<SearchCriteria> criterias) async {
    landSink.add(Result.loading(Constants.LOADING));
    Pagination pagination =
        Pagination(filter: criterias, pageNo: 1, pageSize: 10000);

    final Result<TableResponse> response =
        await _landRepository.getLands(pagination);

    landSink.add(response);
  }

  void dispose() {
    _landController.close();
  }
}
