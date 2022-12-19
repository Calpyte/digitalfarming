import 'package:digitalfarming/blocs/farmer_bloc.dart';
import 'package:digitalfarming/blocs/group_bloc.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/LatLon.dart';
import 'package:digitalfarming/models/farmer.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/ui_state.dart';
import 'package:digitalfarming/views/common/location_detail.dart';
import 'package:digitalfarming/widgets/border_button.dart';
import 'package:digitalfarming/widgets/dropdown_field.dart';
import 'package:digitalfarming/widgets/name_text_field.dart';
import 'package:digitalfarming/widgets/number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';

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
          Constants.FARMER_REGISTRATION,
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
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                NameTextField(
                  name: 'name',
                  hintText: 'First Name',
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'Please enter First Name'),
                  ],
                ),
                const SizedBox(height: 10),
                NameTextField(
                  name: 'lastName',
                  hintText: 'Last Name',
                  validators: [
                    FormBuilderValidators.required(
                      errorText: 'Please enter Last Name',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                NameTextField(
                  name: 'fatherName',
                  hintText: 'Father Name',
                  validators: [
                    FormBuilderValidators.required(
                      errorText: 'Please enter father Name',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                NameTextField(
                  name: 'code',
                  hintText: 'Farmer Code',
                ),
                const SizedBox(height: 10),
                NumberTextField(
                  name: 'mobileNumber',
                  hintText: 'Mobile Number',
                ),
                const SizedBox(height: 10),
                NameTextField(
                  name: 'email',
                  hintText: 'Email',
                  validators: [
                    FormBuilderValidators.required(
                      errorText: 'Please enter Email',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                FormBuilderRadioGroup(
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                        errorText: 'Please select Gender',
                      ),
                    ],
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    fillColor: Colors.green,
                  ),
                  name: 'gender',
                  options: [
                    'Male',
                    'Female',
                  ].map((lang) => FormBuilderFieldOption(value: lang)).toList(
                        growable: false,
                      ),
                  activeColor: Colors.green,
                ),
                const SizedBox(height: 10),
                const LocationDetail(),
                const SizedBox(height: 10),
                DropDownField(
                  name: 'group',
                  items: getItems(groups),
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'Please select Farmer Group'),
                  ],
                  hintText: 'Farmer Group',
                ),
                const SizedBox(height: 10),
                BorderButton(
                  text: 'Submit',
                  onPressed: () => validateAndSave(),
                ),
              ],
            ),
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

  List<DropdownMenuItem> getItems(List<Basic> options) {
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
