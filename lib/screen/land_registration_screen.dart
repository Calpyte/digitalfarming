import 'package:digitalfarming/blocs/farmer_bloc.dart';
import 'package:digitalfarming/blocs/taluk_bloc.dart';
import 'package:digitalfarming/blocs/village_bloc.dart';
import 'package:digitalfarming/models/LatLon.dart';
import 'package:digitalfarming/models/search_criteria.dart';
import 'package:digitalfarming/models/table_response.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/widgets/dropdown_field.dart';
import 'package:digitalfarming/widgets/number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';

import '../models/Basic.dart';
import '../resources/app_logger.dart';
import '../resources/result.dart';
import '../utils/ui_state.dart';
import '../widgets/border_button.dart';
import '../widgets/name_text_field.dart';

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

  List<Basic> taluks = [];
  List<Basic> villages = [];
  List<Basic> farmers = [];

  TalukBloc? talukBloc;
  VillageBloc? villageBloc;
  FarmerBloc? farmerBloc;

  @override
  initState() {
    getMasters();
    super.initState();
  }

  getMasters() {
    talukBloc = TalukBloc();
    villageBloc = VillageBloc();
    farmerBloc = FarmerBloc();

    talukBloc?.talukStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            taluks = snapshot.data;
          });
          break;
      }
    });

    villageBloc?.villageStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            villages = snapshot.data;
          });
          break;
      }
    });

    farmerBloc?.farmerStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          TableResponse tableResponse = snapshot.data as TableResponse;
          setState(() {
            farmers = tableResponse.data!;
            logger.d(farmers.length);
          });
          break;
      }
    });

    talukBloc?.getAllTaluks();
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
                DropDownField(
                  name: 'taluk',
                  items: getItems(taluks),
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'Please select Taluk'),
                  ],
                  hintText: 'Taluk',
                  onChanged: (taluk) => villageBloc?.getVillages(
                    talukId: taluk.id,
                  ),
                ),
                const SizedBox(height: 10),
                DropDownField(
                  name: 'village',
                  items: getItems(villages),
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'Please select Village'),
                  ],
                  hintText: 'Village',
                  onChanged: (village) {
                    SearchCriteria criteria = SearchCriteria(
                      key: 'village.id',
                      operation: ':',
                      value: village.id,
                    );

                    List<SearchCriteria> criterias = [criteria];
                    farmerBloc?.getFarmer(criterias);
                  },
                ),
                const SizedBox(height: 10),
                DropDownField(
                  name: 'farmer',
                  items: getItems(farmers),
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'Please select Farmer'),
                  ],
                  hintText: 'Farmer',
                ),
                const SizedBox(height: 10),
                NameTextField(
                  name: 'name',
                  hintText: 'Land Name',
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'Please enter Land Name'),
                  ],
                ),
                const SizedBox(height: 10),
                NumberTextField(
                  name: 'totalArea',
                  hintText: 'Total Area',
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'Please enter Total Area'),
                  ],
                ),
                const SizedBox(height: 10),
                NumberTextField(
                  name: 'cultivatedArea',
                  hintText: 'Cultivated Area',
                  validators: [],
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

  validateAndSave() async {
    if (_formKey.currentState?.saveAndValidate() ?? true) {
      LatLon latLon = await getLocation();
      Map<String, dynamic>? landValueMap = _formKey.currentState?.value;
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

  List<DropdownMenuItem> getItems(List<Basic> options) {
    return List.generate(
      options.length,
      (index) => DropdownMenuItem(
        value: options[index],
        child: Text(options[index].name ?? ''),
      ),
    );
  }
}
