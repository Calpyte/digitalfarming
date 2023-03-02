import 'package:digitalfarming/blocs/farmer_bloc.dart';
import 'package:digitalfarming/blocs/offline_download_bloc.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/ui_state.dart';
import 'package:digitalfarming/views/loading_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({Key? key}) : super(key: key);

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  UIState _uiState = UIState.completed;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.1,
      width: width,
      color: AppTheme.brandingColor,
      padding: EdgeInsets.only(
          top: height * 0.04, left: width * 0.02, right: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Hi!! Enumerator',
                style: AppTheme.body3White,
              ),
              _widgetForUIState(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _widgetForUIState() {
    double height = MediaQuery.of(context).size.height;
    switch (_uiState) {
      case UIState.loading:
        return const Center(
          child: GFLoader(
            type: GFLoaderType.android,
          ),
        );
      case UIState.completed:
        return IconButton(
          icon: const Icon(
            Icons.sync,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            setState(() {
              _uiState = UIState.loading;
            });
            OfflineDownloadBloc offlineDownloadBloc = OfflineDownloadBloc();
            FarmerBloc farmerBloc = FarmerBloc();
            await offlineDownloadBloc.getOfflineData();
            await farmerBloc.saveOfflineFarmer();
            await farmerBloc.saveOfflineSowing();
            await farmerBloc.saveBinProcessing();
            await farmerBloc.saveProcurement();
            setState(() {
              _uiState = UIState.completed;
            });
          },
        );
      default:
        return const Center(
          child: GFBadge(
            text: 'Sync Failed',
            color: Colors.red,
          ),
        );
    }
  }
}
