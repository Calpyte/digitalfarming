import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../resources/app_logger.dart';
import '../../widgets/name_text_field.dart';
import '../../widgets/number_text_field.dart';

class PersonalFarmer extends StatefulWidget {
  const PersonalFarmer({Key? key}) : super(key: key);

  @override
  State<PersonalFarmer> createState() => _PersonalFarmerState();
}

class _PersonalFarmerState extends State<PersonalFarmer> {
  final logger = AppLogger.get('PersonalFarmer');

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        NameTextField(
          name: 'name',
          hintText: 'First Name',
          validators: [
            FormBuilderValidators.required(
                errorText: 'Please enter First Name'),
          ],
        ),
        SizedBox(height: height * 0.02),
        NameTextField(
          name: 'lastName',
          hintText: 'Last Name',
          validators: [
            FormBuilderValidators.required(
              errorText: 'Please enter Last Name',
            ),
          ],
        ),
        SizedBox(height: height * 0.02),
        NameTextField(
          name: 'fatherName',
          hintText: 'Father Name',
          validators: [
            FormBuilderValidators.required(
              errorText: 'Please enter father Name',
            ),
          ],
        ),
        SizedBox(height: height * 0.02),
        NameTextField(
          name: 'code',
          hintText: 'Farmer Code',
        ),
        SizedBox(height: height * 0.02),
        NumberTextField(
          name: 'mobileNumber',
          hintText: 'Mobile Number',
        ),
        SizedBox(height: height * 0.02),
        NameTextField(
          name: 'email',
          hintText: 'Email',
          validators: [
            FormBuilderValidators.required(
              errorText: 'Please enter Email',
            ),
          ],
        ),
        SizedBox(height: height * 0.02),
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
      ],
    );
  }
}
