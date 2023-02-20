import 'dart:convert';
import 'dart:io';

import 'package:digitalfarming/blocs/catalogue_bloc.dart';
import 'package:digitalfarming/blocs/grade_bloc.dart';
import 'package:digitalfarming/blocs/product_bloc.dart';
import 'package:digitalfarming/blocs/season_bloc.dart';
import 'package:digitalfarming/blocs/variety_bloc.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/LatLon.dart';
import 'package:digitalfarming/models/catalogue.dart';
import 'package:digitalfarming/models/farmer.dart';
import 'package:digitalfarming/models/variety.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/routes.dart';
import 'package:digitalfarming/utils/ui_state.dart';
import 'package:digitalfarming/views/loading_progress_indicator.dart';
import 'package:digitalfarming/views/shadow_card.dart';
import 'package:digitalfarming/widgets/border_button.dart';
import 'package:digitalfarming/widgets/dropdown_field.dart';
import 'package:digitalfarming/widgets/number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'home_screen.dart';

class CultivationScreen extends StatefulWidget {
  static const routeName = '/cultivation';
  final Farmer? farmer;

  const CultivationScreen({Key? key, this.farmer}) : super(key: key);

  @override
  State<CultivationScreen> createState() => _CultivationScreenState();
}

class _CultivationScreenState extends State<CultivationScreen> {
  TextEditingController dateinput = TextEditingController();

  UIState _uiState = UIState.loading;
  final _formKey = GlobalKey<FormBuilderState>();
  SeasonBloc? seasonBloc;
  ProductBloc? productBloc;
  VarietyBloc? varietyBloc;
  GradeBloc? gradeBloc;
  CatalogueBloc? catalogueBloc;
  Farmer? farmer;

  List<Basic> seasons = [];
  List<Basic> products = [];
  List<Variety> varities = [];
  List<Basic> grades = [];
  List<Catalogue> catalogues = [];

  XFile? farmerPhoto;

  @override
  initState() {
    dateinput.text = "";
    getMasters();
    if (widget.farmer != null) {
      setState(() {
        farmer = widget.farmer;
      });
    } else {
      Navigator.pop(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.CULTIVATION,
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
          child: LoadingProgressIndicator(
            alignment: Alignment.center,
          ),
        );
      case UIState.completed:
        return FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.03,
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
                height: height * 0.03,
              ),
              ShadowCard(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    Constants.CULTIVATION_INFORMATION,
                    style: AppTheme.brandHeader,
                  ),
                  SizedBox(height: height * 0.02),
                  GFAccordion(
                    titleChild: Text(
                      ('Farmer : ${farmer!.name}') ?? '',
                      style: AppTheme.headline,
                    ),
                    contentChild: Container(
                       child: Column(
                         children: [
                           Text('Mobile : ${farmer!.mobileNumber}'),
                           Text('Tracenet Id : ${farmer!.code}'),
                         ],
                       ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  FormBuilderTextField(
                    name: 'sowingDateStr',
                    controller: dateinput,
                    readOnly: true,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                          errorText: 'Please select Sowing Date',
                        ),
                      ],
                    ),
                    onTap: () async {
                      var date = DateTime.now();
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                          date.year,
                          date.month - 1,
                          date.day,
                        ),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(
                          date.year,
                          date.month + 1,
                          date.day,
                        ),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('MM/dd/yyyy').format(pickedDate);
                        setState(() {
                          dateinput.text = formattedDate;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Sowing Date',
                      hintStyle: AppTheme.hintText,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppTheme.brandingColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppTheme.brandingColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  DropDownField(
                    name: 'season',
                    items: getItems(seasons),
                    validators: [
                      FormBuilderValidators.required(
                        errorText: 'Please select Season',
                      ),
                    ],
                    hintText: 'Season*',
                  ),
                  SizedBox(height: height * 0.02),
                  DropDownField(
                    name: 'product',
                    items: getItems(products),
                    validators: [
                      FormBuilderValidators.required(
                        errorText: 'Please select Variety',
                      ),
                    ],
                    hintText: 'Product*',
                    onChanged: (v) =>
                        varietyBloc!.getVarieties(productId: v.id),
                  ),
                  SizedBox(height: height * 0.02),
                  DropDownField(
                    name: 'variety',
                    items: getItems(varities),
                    validators: [
                      FormBuilderValidators.required(
                        errorText: 'Please select Variety',
                      ),
                    ],
                    hintText: 'Variety*',
                  ),
                  SizedBox(height: height * 0.02),
                  DropDownField(
                    name: 'cropCategory',
                    items: getItems(catalogues
                        .where((element) => element.type == '15')
                        .toList()),
                    validators: [
                      FormBuilderValidators.required(
                        errorText: 'Please select Crop Category',
                      ),
                    ],
                    hintText: 'Crop Category*',
                  ),
                  SizedBox(height: height * 0.02),
                  DropDownField(
                    name: 'seedSource',
                    items: getItems(catalogues
                        .where((element) => element.type == '14')
                        .toList()),
                    hintText: 'Seed Source',
                  ),
                  SizedBox(height: height * 0.02),
                  DropDownField(
                    name: 'seedType',
                    items: getItems(catalogues
                        .where((element) => element.type == '16')
                        .toList()),
                    hintText: 'Seed Type',
                  ),
                  SizedBox(height: height * 0.02),
                  NumberTextField(
                    name: 'cultivatedArea',
                    hintText: 'Cultivated Area',
                  ),
                  SizedBox(height: height * 0.02),
                  NumberTextField(
                    name: 'proposedArea',
                    hintText: 'Proposed Area',
                  ),
                  SizedBox(height: height * 0.02),
                  NumberTextField(
                    name: 'estimatedYield',
                    hintText: 'Estimated Yield*',
                    validators: [
                      FormBuilderValidators.required(
                        errorText: 'Please enter estimated yield',
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
      Map<String, dynamic>? farmerValueMap = _formKey.currentState?.value;
      setState(() {
        _uiState = UIState.loading;
      });
      var uuid = const Uuid();

      LatLon latLon = await getLocation();
      Map finalMap = Map.of(farmerValueMap!);
      finalMap!['tempSowingId'] = uuid.v4();
      finalMap!['tempFarmerId'] = farmer!.tempFarmerId;
      finalMap!['isSynced'] = false;
      finalMap!['latitude'] = latLon.latitude;
      finalMap!['longitude'] = latLon.longitude;

      if (farmerPhoto != null) {
        finalMap!['imagePath'] = farmerPhoto!.path;
      }

      HiveRepository hiveRepository = HiveRepository();
      String farmerObj = json.encode(finalMap);
      hiveRepository.saveSowing(farmerObj, finalMap['tempSowingId']);

      GFToast.showToast('Sowing Saved Successfully', context,
          toastPosition: GFToastPosition.BOTTOM);

      AppRouter.removeAllAndPush(context, HomeScreen.routeName);
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

  getMasters() async {
    await Future.delayed(const Duration(seconds: 1));
    seasonBloc = SeasonBloc();
    productBloc = ProductBloc();
    varietyBloc = VarietyBloc();
    gradeBloc = GradeBloc();
    catalogueBloc = CatalogueBloc();

    seasonBloc?.seasonStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            seasons = snapshot.data;
          });
          break;
      }
    });

    productBloc?.productStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            products = snapshot.data;
          });
          break;
      }
    });

    varietyBloc?.varietyStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            varities = snapshot.data;
          });
          break;
      }
    });

    gradeBloc?.gradeStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            grades = snapshot.data;
          });
          break;
      }
    });

    catalogueBloc?.catalogueStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            catalogues = snapshot.data;
          });
          break;
      }
    });

    seasonBloc!.getSeasons();
    productBloc!.getProducts();
    catalogueBloc!.getCatalogues();

    setState(() {
      _uiState = UIState.completed;
    });
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
}
