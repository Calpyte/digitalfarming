import 'package:digitalfarming/models/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';

import '../../blocs/farmer_bloc.dart';
import '../../blocs/taluk_bloc.dart';
import '../../blocs/village_bloc.dart';
import '../../models/Basic.dart';
import '../../models/LatLon.dart';
import '../../models/search_criteria.dart';
import '../../models/table_response.dart';
import '../../resources/app_logger.dart';
import '../../resources/result.dart';
import '../../utils/app_colors.dart';
import '../../widgets/dropdown_field.dart';
import '../../widgets/name_text_field.dart';
import '../../widgets/number_text_field.dart';

class LandDetail extends StatefulWidget {
  const LandDetail({Key? key}) : super(key: key);

  @override
  State<LandDetail> createState() => _LandDetailState();
}

class _LandDetailState extends State<LandDetail> {
  final _formKey = GlobalKey<FormBuilderState>();
  final logger = AppLogger.get('LandDetail');

  List<Location> taluks = [];
  List<Location> villages = [];
  List<Basic> farmers = [];

  TalukBloc? talukBloc;
  VillageBloc? villageBloc;
  FarmerBloc? farmerBloc;

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        DropDownField(
          name: 'taluk',
          items: getItems(taluks),
          validators: [
            FormBuilderValidators.required(errorText: 'Please select Taluk'),
          ],
          hintText: 'Taluk',
          onChanged: (taluk) => villageBloc?.getVillages(
            talukId: taluk.id,
          ),
        ),
        SizedBox(height: height * 0.02),
        DropDownField(
          name: 'village',
          items: getItems(villages),
          validators: [
            FormBuilderValidators.required(errorText: 'Please select Village'),
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
        SizedBox(height: height * 0.02),
        DropDownField(
          name: 'farmer',
          items: getItems(farmers),
          validators: [
            FormBuilderValidators.required(errorText: 'Please select Farmer'),
          ],
          hintText: 'Farmer',
        ),
        SizedBox(height: height * 0.02),
        NameTextField(
          name: 'name',
          hintText: 'Land Name',
          validators: [
            FormBuilderValidators.required(errorText: 'Please enter Land Name'),
          ],
        ),
        SizedBox(height: height * 0.02),
        NumberTextField(
          name: 'totalArea',
          hintText: 'Total Area (Acres)',
          validators: [
            FormBuilderValidators.required(
                errorText: 'Please enter Total Area'),
          ],
        ),
        SizedBox(height: height * 0.02),
        NumberTextField(
          name: 'cultivatedArea',
          hintText: 'Cultivated Area (Acres)',
          validators: const [],
        ),
        SizedBox(height: height * 0.02),
        FormBuilderRadioGroup(
          initialValue: 'No',
          validator: FormBuilderValidators.compose(
            [
              FormBuilderValidators.required(
                errorText: 'Please select Gender',
              ),
            ],
          ),
          decoration: const InputDecoration(
            labelText: 'Do you want to Geo Tag / Plot Land ?',
            fillColor: Colors.green,
          ),
          name: 'plot',
          options: [
            'Yes',
            'No',
          ].map((lang) => FormBuilderFieldOption(value: lang)).toList(
                growable: false,
              ),
          activeColor: Colors.green,
          onChanged: (v) {
            if (v == 'Yes') {
              setState(() {
                showPlot = 1;
              });
            } else {
              setState(() {
                showPlot = 0;
              });
            }
          },
        ),
        SizedBox(height: height * 0.02),
        showPlot == 1
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          startPoint = await getLocation();
                        },
                        padding: const EdgeInsets.all(0),
                        minWidth: 90,
                        height: 40,
                        elevation: 5,
                        color: AppColors.green,
                        child: const Text('Start'),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          intermediatePoints.add(await getLocation());
                        },
                        padding: const EdgeInsets.all(0),
                        minWidth: 90,
                        height: 40,
                        elevation: 5,
                        color: AppColors.grey,
                        child: const Text('Intermediate'),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          endPoint = await getLocation();
                        },
                        padding: const EdgeInsets.all(0),
                        minWidth: 90,
                        height: 40,
                        elevation: 5,
                        color: AppColors.red,
                        child: const Text('End'),
                      ),
                    ],
                  ),
                ],
              )
            : Container(),
      ],
    );
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
