import 'package:digitalfarming/blocs/client/offline_download_client.dart';
import 'package:digitalfarming/models/offline_download.dart';
import 'package:digitalfarming/resources/hive_provider.dart';
import 'package:digitalfarming/resources/hive_repository.dart';

import '../../resources/result.dart';

class OfflineDownloadRepository {
  OfflineDownloadRepository({OfflineDownloadClient? client}) {
    _client = client ?? OfflineDownloadClient();
  }

  OfflineDownloadClient _client = OfflineDownloadClient();

  Future<Result<OfflineDownload>> getOfflineData() async {
    Result<OfflineDownload> offlineDownload = await _client.getMasterData();
    Result<dynamic> farmerData = await _client.getFarmerData();
    Result<dynamic> sowingData = await _client.getSowingData();
    HiveProvider hiveProvider = HiveProvider();
    HiveRepository hiveRepository = HiveRepository();
    await hiveProvider.syncMasterData(offlineDownload.data!);
    await hiveRepository.syncFarmerData(farmerData.data);
    await hiveRepository.syncSowingData(sowingData.data);
    return offlineDownload;
  }
}
