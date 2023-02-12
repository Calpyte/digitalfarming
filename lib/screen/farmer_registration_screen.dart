import 'package:digitalfarming/blocs/farmer_bloc.dart';
import 'package:digitalfarming/blocs/group_bloc.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/LatLon.dart';
import 'package:digitalfarming/models/farmer.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';

import '../views/common/location_detail.dart';
import '../views/common/personal_farmer.dart';
import '../views/shadow_card.dart';
import '../widgets/border_button.dart';
import '../widgets/dropdown_field.dart';

class FarmerRegistrationScreen extends StatefulWidget {
  static const routeName = '/farmer-registration';

  const FarmerRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<FarmerRegistrationScreen> createState() =>
      _FarmerRegistrationScreenState();
}

class _FarmerRegistrationScreenState extends State<FarmerRegistrationScreen> {
  List<Basic> groups = [];
  final _formKey = GlobalKey<FormBuilderState>();
  GroupBloc? groupBloc;
  FarmerBloc? farmerBloc;
  UIState _uiState = UIState.completed;

  @override
  initState() {
    groupBloc = GroupBloc();
    farmerBloc = FarmerBloc();
    getMasters();
    super.initState();
  }

  getMasters() {
    groupBloc?.groupStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            groups = snapshot.data;
          });
          break;
      }
    });

    farmerBloc?.farmerStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.loading:
          setState(() {
            _uiState = UIState.loading;
          });
          break;
        case Status.completed:
          GFToast.showToast('Farmer Saved Successfully', context,
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

    groupBloc?.getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.FARMER_DETAILS,
          style: AppTheme.body,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const PageScrollPhysics(),
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
                  const SizedBox(height: 10),
                  const Text(
                    Constants.PERSONAL_FARMER,
                    style: AppTheme.brandHeader,
                  ),
                  SizedBox(height: height * 0.02),
                  const PersonalFarmer(),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              ShadowCard(
                children: [
                  const Text(
                    Constants.LOCATION_DETAILS,
                    style: AppTheme.brandHeader,
                  ),
                  SizedBox(height: height * 0.02),
                  const LocationDetail(),
                  SizedBox(height: height * 0.02),
                  DropDownField(
                    name: 'group',
                    items: getItems(groups),
                    validators: [
                      FormBuilderValidators.required(
                          errorText: 'Please select Farmer Group'),
                    ],
                    hintText: 'Farmer Group',
                  ),
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

  List<DropdownMenuItem> getItems(List<dynamic> options) {
    return List.generate(
      options.length,
      (index) => DropdownMenuItem(
        value: options[index],
        child: Text(options[index].name ?? ''),
      ),
    );
  }

  validateAndSave() async {
    if (_formKey.currentState?.saveAndValidate() ?? true) {
      LatLon latLon = await getLocation();
      Map<String, dynamic>? farmerValueMap = _formKey.currentState?.value;
      Farmer farmer = Farmer.fromFormJson(farmerValueMap!);
      farmer.latitude = latLon.latitude;
      farmer.longitude = latLon.longitude;
      farmerBloc?.saveFarmer(farmer: farmer);
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
