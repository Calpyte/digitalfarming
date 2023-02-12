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
    HiveProvider hiveProvider = HiveProvider();
    HiveRepository hiveRepository = HiveRepository();
    hiveProvider.syncMasterData(offlineDownload.data!);
    hiveRepository.syncFarmerData(farmerData.data);
    return offlineDownload;
  }
}
