import 'package:digitalfarming/blocs/country_bloc.dart';
import 'package:digitalfarming/models/country.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/widgets/border_button.dart';
import 'package:digitalfarming/widgets/dropdown_field.dart';
import 'package:digitalfarming/widgets/name_text_field.dart';
import 'package:digitalfarming/widgets/number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FarmerRegistrationScreen extends StatefulWidget {
  static const routeName = '/farmer-registration';

  const FarmerRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<FarmerRegistrationScreen> createState() =>
      _FarmerRegistrationScreenState();
}

class _FarmerRegistrationScreenState extends State<FarmerRegistrationScreen> {
  CountryBloc? countryBloc;

  List<Country> countries = [];

  @override
  initState() {
    getMasters();
    super.initState();
  }

  getMasters() {
    countryBloc = CountryBloc();

    countryBloc?.countryStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.completed:
          setState(() {
            countries = _snapshot.data;
          });
          break;
      }
    });
    countryBloc?.getCountries();
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
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              NameTextField(
                name: 'name',
                hintText: 'First Name',
              ),
              const SizedBox(height: 10),
              NameTextField(
                name: 'lastName',
                hintText: 'Last Name',
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
              NumberTextField(
                name: 'email',
                hintText: 'Email',
              ),
              const SizedBox(height: 10),
              FormBuilderRadioGroup(
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                      errorText: 'Please select User Type',
                    ),
                  ],
                ),
                decoration: const InputDecoration(
                    labelText: 'Gender', fillColor: Colors.green),
                name: 'Gender',
                options: [
                  'Male',
                  'Female',
                ].map((lang) => FormBuilderFieldOption(value: lang)).toList(
                      growable: false,
                    ),
                activeColor: Colors.green,
              ),
              const SizedBox(height: 10),
              DropDownField(
                name: 'country',
                items: List.generate(
                  countries.length,
                  (index) => DropdownMenuItem(
                    value: countries[index],
                    child: Text(countries[index].name ?? ''),
                  ),
                ),
                validators: [
                  FormBuilderValidators.required(
                      errorText: 'Please select Country'),
                ],
                hintText: 'Country',
              ),
              const SizedBox(height: 10),
              DropDownField(
                name: 'state',
                items: [],
                validators: [],
                hintText: 'State',
              ),
              const SizedBox(height: 10),
              DropDownField(
                name: 'district',
                items: [],
                validators: [],
                hintText: 'District',
              ),
              const SizedBox(height: 10),
              DropDownField(
                name: 'taluk',
                items: [],
                validators: [],
                hintText: 'Taluk',
              ),
              const SizedBox(height: 10),
              DropDownField(
                name: 'village',
                items: [],
                validators: [],
                hintText: 'Village',
              ),
              const SizedBox(height: 10),
              DropDownField(
                name: 'group',
                items: [],
                validators: [],
                hintText: 'Farmer Group',
              ),
              const SizedBox(height: 10),
              BorderButton(text: 'Submit', onPressed: () => {}),
            ],
          ),
        ),
      ),
    );
  }
}
