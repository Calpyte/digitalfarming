import 'dart:async';

import 'package:digitalfarming/blocs/repository/offline_download_repository.dart';
import 'package:digitalfarming/models/offline_download.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class OfflineDownloadBloc {
  final logger = AppLogger.get('OfflineDownloadBloc');

  final OfflineDownloadRepository _offlineRepository = OfflineDownloadRepository();

  final StreamController<Result> _offlineController =
      StreamController<Result>();

  StreamSink get offlineSink => _offlineController.sink;
  Stream<Result> get offlineStream => _offlineController.stream;


  Future<void> getOfflineData() async {
    offlineSink.add(Result.loading(Constants.LOADING));
    final Result<OfflineDownload> response = await _offlineRepository.getOfflineData();
    offlineSink.add(response);
  }

  void dispose() {
    _offlineController.close();
  }

}
