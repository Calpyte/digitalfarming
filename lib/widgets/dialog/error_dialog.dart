import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';
import 'dialog_util.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          dismissDialog(context);
        },
        child: Container(
          width: double.infinity,
          color: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
                child: Text(message,
                    textAlign: TextAlign.center, style: AppTheme.subtitle)),
          ),
        ),
      ),
    );
  }
}
