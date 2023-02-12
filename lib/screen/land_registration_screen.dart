import 'package:digitalfarming/blocs/land_bloc.dart';
import 'package:digitalfarming/models/LatLon.dart';
import 'package:digitalfarming/models/farm_coordinates.dart';
import 'package:digitalfarming/models/land.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:getwidget/types/gf_loader_type.dart';

import '../resources/app_logger.dart';
import '../resources/result.dart';
import '../utils/ui_state.dart';
import '../views/common/land_detail.dart';
import '../views/shadow_card.dart';
import '../widgets/border_button.dart';

class LandRegistrationScreen extends StatefulWidget {
  static const routeName = '/land-registration';
  const LandRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<LandRegistrationScreen> createState() => _LandRegistrationScreenState();
}

class _LandRegistrationScreenState extends State<LandRegistrationScreen> {
  UIState _uiState = UIState.completed;
  final _formKey = GlobalKey<FormBuilderState>();

  final logger = AppLogger.get('_LandRegistrationScreenState');
  LandBloc? landBloc;
  int showPlot = 0;

  LatLon? startPoint;
  LatLon? endPoint;
  List<LatLon> intermediatePoints = [];

  @override
  initState() {
    getMasters();
    super.initState();
  }

  getMasters() {
    landBloc = LandBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.LAND_REGISTRATION,
          style: AppTheme.body,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: _widgetForUIState(),
      ),
    );
  }

  Widget _widgetForUIState() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    switch (_uiState) {
      case UIState.loading:
        return const Center(
          child: GFLoader(
            type: GFLoaderType.square,
          ),
        );
      case UIState.completed:
        return FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              ShadowCard(
                children: [
                  const Text(
                    Constants.LAND_DETAIL,
                    style: AppTheme.brandHeader,
                  ),
                  SizedBox(height: height * 0.02),
                  const LandDetail(),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              BorderButton(
                text: 'Submit',
                onPressed: () => validateAndSave(),
              ),
            ],
          ),
        );
      default:
        return const Center(
          child: GFBadge(
            text: 'Internal Server Error',
            color: Colors.red,
          ),
        );
    }
  }

  validateAndSave() async {
    if (_formKey.currentState?.saveAndValidate() ?? true) {
      LatLon latLon = await getLocation();
      Map<String, dynamic>? landValueMap = _formKey.currentState?.value;
      Land land = Land.fromFormJson(landValueMap!);
      land.latitude = latLon.latitude;
      land.longitude = latLon.longitude;

      if (startPoint != null &&
          intermediatePoints.isNotEmpty &&
          endPoint != null) {
        int seq = 0;
        List<FarmCoordinates> coordinates = [];

        coordinates.add(FarmCoordinates(
            latitude: startPoint?.latitude,
            longitude: startPoint?.longitude,
            sequenceNumber: seq));

        List.generate(intermediatePoints.length, (index) {
          seq++;
          coordinates.add(FarmCoordinates(
            latitude: intermediatePoints[index].latitude,
            longitude: intermediatePoints[index].longitude,
            sequenceNumber: seq,
          ));
        });

        coordinates.add(FarmCoordinates(
          latitude: endPoint?.latitude,
          longitude: endPoint?.longitude,
          sequenceNumber: seq,
        ));

        land.farmCoordinates = coordinates;
      }

      landBloc?.saveLand(land: land);

      landBloc?.landStream.listen((snapshot) {
        switch (snapshot.status) {
          case Status.loading:
            setState(() {
              _uiState = UIState.loading;
            });
            break;
          case Status.completed:
            GFToast.showToast('Land Saved Successfully', context,
                toastPosition: GFToastPosition.BOTTOM);
            setState(() {
              _uiState = UIState.completed;
            });

            Navigator.pop(context);
            break;
          case Status.error:
            GFToast.showToast('Internal Server Error', context);
            setState(() {
              _uiState = UIState.error;
            });
            break;
        }
      });
    }
  }

  Future<LatLon> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }

    final Position position = await Geolocator.getCurrentPosition();
    return LatLon(latitude: position.latitude, longitude: position.longitude);
  }
}
