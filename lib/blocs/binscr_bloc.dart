import 'dart:async';

import 'package:digitalfarming/blocs/repository/binscr_repository.dart';

import '../models/bin_scr.dart';
import '../resources/result.dart';
import '../utils/constants.dart';

class BinBloc {
  final BinRepository _binrRepository = BinRepository();

  final StreamController<Result> _binController = StreamController<Result>();

  StreamSink get binSink => _binController.sink;
  Stream<Result> get binStream => _binController.stream;

  Future<void> saveBin({required Bin binScr}) async {
    binSink.add(Result.loading(Constants.LOADING));
    final Result<String> response =
        await _binrRepository.saveBin(binScr: binScr);
    binSink.add(Result.completed(response));
  }

  void dispose() {
    _binController.close();
  }
}
