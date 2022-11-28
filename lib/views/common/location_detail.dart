import 'package:digitalfarming/blocs/country_bloc.dart';
import 'package:digitalfarming/blocs/district_bloc.dart';
import 'package:digitalfarming/blocs/state_bloc.dart';
import 'package:digitalfarming/blocs/taluk_bloc.dart';
import 'package:digitalfarming/blocs/village_bloc.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/widgets/dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LocationDetail extends StatefulWidget {
  const LocationDetail({Key? key}) : super(key: key);

  @override
  State<LocationDetail> createState() => _LocationDetailState();
}

class _LocationDetailState extends State<LocationDetail> {
  CountryBloc? countryBloc;
  StateBloc? stateBloc;
  DistrictBloc? districtBloc;
  TalukBloc? talukBloc;
  VillageBloc? villageBloc;

  List<Basic> countries = [];
  List<Basic> states = [];
  List<Basic> districts = [];
  List<Basic> taluks = [];
  List<Basic> villages = [];

  @override
  initState() {
    getMasters();
    super.initState();
  }

  getMasters() {
    countryBloc = CountryBloc();
    stateBloc = StateBloc();
    districtBloc = DistrictBloc();
    talukBloc = TalukBloc();
    villageBloc = VillageBloc();

    countryBloc?.countryStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            countries = snapshot.data;
          });
          break;
      }
    });

    stateBloc?.stateStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            states = snapshot.data;
          });
          break;
      }
    });

    districtBloc?.districtStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            districts = snapshot.data;
          });
          break;
      }
    });

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

    countryBloc?.getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropDownField(
          name: 'country',
          items: getItems(countries),
          validators: [
            FormBuilderValidators.required(errorText: 'Please select Country'),
          ],
          hintText: 'Country',
          onChanged: (country) => stateBloc?.getStates(countryId: country.id),
        ),
        const SizedBox(height: 10),
        DropDownField(
          name: 'state',
          items: getItems(states),
          validators: [
            FormBuilderValidators.required(errorText: 'Please select State'),
          ],
          hintText: 'State',
          onChanged: (state) => districtBloc?.getDistricts(stateId: state.id),
        ),
        const SizedBox(height: 10),
        DropDownField(
          name: 'district',
          items: getItems(districts),
          validators: [
            FormBuilderValidators.required(errorText: 'Please select District'),
          ],
          hintText: 'District',
          onChanged: (district) =>
              talukBloc?.getTaluks(districtId: district.id),
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
        DropDownField(
          name: 'village',
          items: getItems(villages),
          validators: [
            FormBuilderValidators.required(errorText: 'Please select Village'),
          ],
          hintText: 'Village',
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
