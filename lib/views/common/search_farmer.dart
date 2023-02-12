import 'package:digitalfarming/blocs/farmer_bloc.dart';
import 'package:digitalfarming/blocs/taluk_bloc.dart';
import 'package:digitalfarming/blocs/village_bloc.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/models/search_criteria.dart';
import 'package:digitalfarming/models/table_response.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/ui_state.dart';
import 'package:digitalfarming/widgets/dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SearchFarmer extends StatefulWidget {
  const SearchFarmer({Key? key}) : super(key: key);

  @override
  State<SearchFarmer> createState() => _SearchFarmerState();
}

class _SearchFarmerState extends State<SearchFarmer> {
  final logger = AppLogger.get('SearchFarmer');

  UIState _uiState = UIState.completed;

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
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
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
        SizedBox(height: height * 0.02),
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
        SizedBox(height: height * 0.02),
        DropDownField(
          name: 'farmer',
          items: getItems(farmers),
          validators: [
            FormBuilderValidators.required(
              errorText: 'Please select Farmer',
            ),
          ],
          hintText: 'Farmer',
        ),
      ],
    );
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
