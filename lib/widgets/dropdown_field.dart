import 'package:digitalfarming/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../utils/app_theme.dart';

class DropDownField extends FormBuilderDropdown {
  DropDownField(
      {Key? key,
      required this.name,
      required this.items,
      this.validators,
      this.onChanged,
      this.hintText})
      : super(
          key: key,
          name: name,
          items: items,
          validator: FormBuilderValidators.compose(
            validators ?? [],
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTheme.hintText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.card_black, width: 0.0),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.green, width: 0.0),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 0.0),
            ),
          ),
        );

  final String? hintText;
  final String name;
  final List<DropdownMenuItem> items;
  final List<FormFieldValidator<dynamic>>? validators;
  final ValueChanged? onChanged;
}
