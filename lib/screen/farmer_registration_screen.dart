import 'dart:convert';
import 'dart:io';

import 'package:digitalfarming/blocs/farmer_bloc.dart';
import 'package:digitalfarming/blocs/group_bloc.dart';
import 'package:digitalfarming/blocs/image_bloc.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/LatLon.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/screen/home_screen.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/routes.dart';
import 'package:digitalfarming/utils/ui_state.dart';
import 'package:digitalfarming/views/loading_progress_indicator.dart';
import 'package:digitalfarming/widgets/name_text_field.dart';
import 'package:digitalfarming/widgets/number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

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
  XFile? farmerPhoto;
  XFile? farmPhoto;
  UIState _uiState = UIState.completed;
  String? imageId;
  ImageBloc imageBloc = ImageBloc();

  @override
  initState() {
    groupBloc = GroupBloc();
    farmerBloc = FarmerBloc();
    setState(() {
      _uiState = UIState.loading;
    });
    getMasters();
    super.initState();
  }

  getMasters() async {
    await Future.delayed(const Duration(seconds: 1));
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

    imageBloc?.imageStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.loading:
          setState(() {
            _uiState = UIState.loading;
          });
          break;
        case Status.completed:
          Result<String> resultData = snapshot.data;
          setState(() {
            imageId = resultData.data;
          });
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

    setState(() {
      _uiState = UIState.completed;
    });
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
    switch (_uiState) {
      case UIState.loading:
        return const Center(
          child: LoadingProgressIndicator(
            alignment: Alignment.center,
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
              Center(
                child: InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? photo =
                        await picker.pickImage(source: ImageSource.camera);
                    setState(() {
                      farmerPhoto = photo;
                    });
                  },
                  child: GFAvatar(
                    size: 50,
                    backgroundColor: Colors.white,
                    child: farmerPhoto == null
                        ? const Icon(Icons.camera_alt)
                        : GFImageOverlay(
                            height: 200,
                            width: 200,
                            shape: BoxShape.circle,
                            image: FileImage(
                              File(farmerPhoto!.path),
                            ),
                          ),
                  ),
                ),
              ),
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
                        errorText: 'Please select Farmer Group',
                      ),
                    ],
                    hintText: 'Farmer Group',
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              ShadowCard(
                children: [
                  SizedBox(height: height * 0.01),
                  const Text(
                    Constants.LAND_REGISTRATION,
                    style: AppTheme.brandHeader,
                  ),
                  SizedBox(height: height * 0.02),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? photo =
                            await picker.pickImage(source: ImageSource.camera);
                        setState(() {
                          farmPhoto = photo;
                        });
                      },
                      child: farmPhoto == null
                          ? GFAvatar(
                              size: 50,
                              backgroundColor: Colors.white,
                              child: farmPhoto == null
                                  ? const Icon(Icons.camera_alt)
                                  : GFImageOverlay(
                                      height: 200,
                                      width: 200,
                                      shape: BoxShape.circle,
                                      image: FileImage(
                                        File(farmPhoto!.path),
                                      ),
                                    ),
                            )
                          : GFImageOverlay(
                              height: 200,
                              width: 300,
                              image: FileImage(
                                File(farmPhoto!.path),
                              )),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  NameTextField(
                    name: 'landName',
                    hintText: 'Land Name',
                  ),
                  SizedBox(height: height * 0.02),
                  NumberTextField(
                    name: 'totalAcres',
                    hintText: 'Total Area(Acres)',
                    validators: [
                      FormBuilderValidators.required(
                          errorText: 'Please enter total no of Acres'),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  NumberTextField(
                    name: 'cultivatedAcres',
                    hintText: 'Total Area Cultivated(Acres)',
                    validators: [
                      FormBuilderValidators.required(
                          errorText: 'Please enter Total Area Cultivated'),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
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
      Map<String, dynamic>? farmerValueMap = _formKey.currentState?.value;
      setState(() {
        _uiState = UIState.loading;
      });
      var uuid = const Uuid();

      LatLon latLon = await getLocation();
      Map finalMap = Map.of(farmerValueMap!);
      finalMap!['tempFarmerId'] = uuid.v4();
      finalMap!['isSynced'] = false;
      if (farmerPhoto != null) {
        finalMap!['imagePath'] = farmerPhoto!.path;
      }
      if (farmPhoto != null) {
        finalMap!['farmImagePath'] = farmPhoto!.path;
      }
      finalMap!['latitude'] = latLon.latitude;
      finalMap!['longitude'] = latLon.longitude;

      HiveRepository hiveRepository = HiveRepository();
      String farmerObj = json.encode(finalMap);
      hiveRepository.saveFarmer(farmerObj, finalMap['tempFarmerId']);

      GFToast.showToast('Farmer Saved Successfully', context,
          toastPosition: GFToastPosition.BOTTOM);

      AppRouter.removeAllAndPush(context, HomeScreen.routeName);
    } else {
      setState(() {
        _uiState = UIState.completed;
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
