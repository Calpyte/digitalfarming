// ignore_for_file: unnecessary_import

import 'package:digitalfarming/utils/app_colors.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class NumberTextField extends FormBuilderTextField {
  NumberTextField(
      {this.hintText,
      this.textEditingController,
      required this.name,
      this.validators})
      : super(
          name: name,
          controller: textEditingController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTheme.hintText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.green, width: 1.0),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.green, width: 0.0),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 0.0),
            ),
          ),
          validator: FormBuilderValidators.compose(
            validators ?? [],
          ),
        );

  final String? hintText;
  final TextEditingController? textEditingController;
  final String name;
  final List<FormFieldValidator<dynamic>>? validators;
}
