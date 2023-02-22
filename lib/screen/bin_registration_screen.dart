import 'dart:convert';

import 'package:digitalfarming/blocs/bin_bloc.dart';
import 'package:digitalfarming/blocs/product_bloc.dart';
import 'package:digitalfarming/models/LatLon.dart';
import 'package:digitalfarming/resources/hive_repository.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/views/common/search_crop.dart';
import 'package:digitalfarming/views/shadow_card.dart';
import 'package:digitalfarming/widgets/border_button.dart';
import 'package:digitalfarming/widgets/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

import '../models/Basic.dart';

class BinRegistrationScreen extends StatefulWidget {
  static const routeName = '/bin-registration';
  const BinRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<BinRegistrationScreen> createState() => _BinRegistrationScreenState();
}

class _BinRegistrationScreenState extends State<BinRegistrationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  ProductBloc? productBloc;
  BinBloc? binBloc;

  List<Basic> products = [];
  String selectedProduct = '';

  @override
  void initState() {
    productBloc = ProductBloc();
    binBloc = BinBloc();
    productBloc?.productStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            products = snapshot.data;
          });
          break;
      }
    });

    productBloc?.getProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.BIN_REGISTRATION,
          style: AppTheme.body,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
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
                    Constants.BIN_REGISTRATION,
                    style: AppTheme.brandHeader,
                  ),
                  SizedBox(height: height * 0.02),
                  NameTextField(
                    name: 'name',
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
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

              BorderButton(
                text: 'Submit',
                onPressed: () => validateAndSave(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateAndSave() async {
    if (_formKey.currentState?.saveAndValidate() ?? true) {
      var uuid = const Uuid();
      Map<String, dynamic>? farmerValueMap = _formKey.currentState?.value;
      LatLon latLon = await getLocation();
      Map finalMap = Map.of(farmerValueMap!);
      finalMap!['tempBinId'] = uuid.v4();
      finalMap!['isSynced'] = false;
      finalMap!['latitude'] = latLon.latitude;
      finalMap!['longitude'] = latLon.longitude;

      HiveRepository hiveRepository = HiveRepository();
      String binObj = json.encode(finalMap);
      hiveRepository.saveBin(binObj, finalMap['tempBinId']);
      Navigator.pop(context);
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
