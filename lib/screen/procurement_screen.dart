import 'package:digitalfarming/blocs/farmer_bloc.dart';
import 'package:digitalfarming/blocs/taluk_bloc.dart';
import 'package:digitalfarming/blocs/village_bloc.dart';
import 'package:digitalfarming/models/LatLon.dart';
import 'package:digitalfarming/models/procurement.dart';
import 'package:digitalfarming/models/table_response.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/screen/bin_selection_screen.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/next_screen.dart';
import 'package:digitalfarming/utils/ui_state.dart';
import 'package:digitalfarming/views/common/search_crop.dart';
import 'package:digitalfarming/views/common/search_farmer.dart';
import 'package:digitalfarming/views/shadow_card.dart';
import 'package:digitalfarming/widgets/name_text_field.dart';
import 'package:digitalfarming/widgets/number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';

import '../models/Basic.dart';
import '../widgets/border_button.dart';

class ProcurementScreen extends StatefulWidget {
  static const routeName = '/procurement-screen';

  const ProcurementScreen({Key? key}) : super(key: key);

  @override
  State<ProcurementScreen> createState() => _ProcurementScreenState();
}

class _ProcurementScreenState extends State<ProcurementScreen> {
  UIState _uiState = UIState.completed;
  final _formKey = GlobalKey<FormBuilderState>();

  final logger = AppLogger.get('_ProcurementScreenState');

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
          Constants.PROCUREMENT,
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
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              ShadowCard(
                children: [
                  const Text(
                    Constants.FARMER_DETAILS,
                    style: AppTheme.brandHeader,
                  ),
                  SizedBox(height: height * 0.02),
                  const SearchFarmer(),
                ],
              ),
              SizedBox(height: height * 0.02),
              ShadowCard(
                children: [
                  const Text(
                    Constants.CROP_DETAILS,
                    style: AppTheme.brandHeader,
                  ),
                  SizedBox(height: height * 0.02),
                  const SearchCrop(),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              ShadowCard(
                children: [
                  const Text(
                    Constants.PROCUREMENT_INFO,
                    style: AppTheme.brandHeader,
                  ),
                  SizedBox(height: height * 0.02),
                  const Text(
                    Constants.INPUT_WEIGHT,
                    style: AppTheme.brandLabel,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  NumberTextField(
                    name: 'totalWeight',
                    validators: [
                      FormBuilderValidators.required(
                          errorText: 'Please enter Input Weight'),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  const Text(
                    Constants.AMOUNT,
                    style: AppTheme.brandLabel,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  NumberTextField(
                    name: 'price',
                    validators: [
                      FormBuilderValidators.required(
                          errorText: 'Please enter Amount'),
                    ],
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

  validateAndSave() async {
    if (_formKey.currentState?.saveAndValidate() ?? true) {
      LatLon latLon = await getLocation();
      Map<String, dynamic>? procurementValueMap = _formKey.currentState?.value;
      Procurement procurement = Procurement.fromFormJson(procurementValueMap!);
      procurement.latitude = latLon.latitude;
      procurement.longitude = latLon.longitude;

      nextScreen(context, BinSelectionScreen(procurement: procurement));
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
