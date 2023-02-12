import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../utils/app_theme.dart';

class NameTextField extends FormBuilderTextField {
  NameTextField(
      {Key? key,
      this.hintText,
      this.textEditingController,
      required this.name,
      this.validators,
      this.maxLines,
      this.readOnly})
      : super(
          key: key,
          name: name,
          controller: textEditingController,
          keyboardType: TextInputType.text,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTheme.hintText,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppTheme.brandingColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppTheme.brandingColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          validator: FormBuilderValidators.compose(
            validators ?? [],
          ),
          readOnly: readOnly ?? false,
        );

  final String? hintText;
  final TextEditingController? textEditingController;
  final String name;
  final List<FormFieldValidator<dynamic>>? validators;
  int? maxLines = 1;
  bool? readOnly = false;
}
