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
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.green,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.green, width: 3.0),
              borderRadius: BorderRadius.circular(3),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 3.0),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );

  final String? hintText;
  final String name;
  final List<DropdownMenuItem> items;
  final List<FormFieldValidator<dynamic>>? validators;
  final ValueChanged? onChanged;
}
