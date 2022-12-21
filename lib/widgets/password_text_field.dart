import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_theme.dart';

class PasswordTextField extends FormBuilderTextField {
  PasswordTextField(
      {this.hintText,
      this.textEditingController,
      required this.name,
      this.validators,
      this.readOnly})
      : super(
          name: name,
          controller: textEditingController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTheme.hintText,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.card_black, width: 0.0),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.green, width: 0.0),
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 0.0),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          validator: FormBuilderValidators.compose(
            validators ?? [],
          ),
          readOnly: readOnly ?? false,
          obscureText: true,
        );

  final String? hintText;
  final TextEditingController? textEditingController;
  final String name;
  final List<FormFieldValidator<dynamic>>? validators;
  bool? readOnly = false;
}
