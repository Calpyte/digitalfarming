import 'dart:async';

import 'package:digitalfarming/blocs/repository/group_repository.dart';
import 'package:digitalfarming/blocs/repository/season_repository.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class SeasonBloc {
  final logger = AppLogger.get('SeasonBloc');
  final SeasonRepository _seasonRepository = SeasonRepository();

  final StreamController<Result> _seasonController = StreamController<Result>();

  StreamSink get seasonSink => _seasonController.sink;
  Stream<Result> get seasonStream => _seasonController.stream;

  Future<void> getSeasons() async {
    seasonSink.add(Result.loading(Constants.LOADING));
    final Result<List<Basic>> response = await _seasonRepository.getSeasons();
    seasonSink.add(response);
  }

  void dispose() {
    _seasonController.close();
  }
}
