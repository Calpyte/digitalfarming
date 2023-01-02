import 'dart:async';

import 'package:digitalfarming/blocs/repository/bin_repository.dart';
import 'package:digitalfarming/blocs/repository/product_repository.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/bin.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class BinBloc {
  final logger = AppLogger.get('BinBloc');
  final BinRepository _binRepository = BinRepository();

  final StreamController<Result> _binController =
      StreamController<Result>();

  StreamSink get binSink => _binController.sink;
  Stream<Result> get binStream => _binController.stream;


  Future<void> saveBin({required Bin bin}) async {
    binSink.add(Result.loading(Constants.LOADING));
    final Result<String> response =
    await _binRepository.saveBin(bin: bin);
    binSink.add(Result.completed(response));
  }

  Future<void> getBins() async {
    binSink.add(Result.loading(Constants.LOADING));
    final Result<List<Bin>> response = await _binRepository.getBins();
    binSink.add(response);
  }

  void dispose() {
    _binController.close();
  }
}
