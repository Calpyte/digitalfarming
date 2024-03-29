import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../loading_dialog.dart';
import 'error_dialog.dart';

void showLoadingDialog(BuildContext buildContext) {
  showDialog(
    context: buildContext,
    builder: (BuildContext context) {
      return LoadingDialog();
    },
  );
}

void showPopupDialog(BuildContext buildContext, Widget child) {
  showDialog(
    context: buildContext,
    builder: (BuildContext context) {
      return child;
    },
  );
}

void showMessage(String message, BuildContext context) {
  Flushbar(
    forwardAnimationCurve: Curves.ease,
    duration: const Duration(seconds: 2),
    message: message,
  ).show(context);
}

void showErrorDialog(BuildContext buildContext, String message) {
  showDialog(
    barrierDismissible: true,
    context: buildContext,
    builder: (BuildContext context) {
      return ErrorDialog(message);
    },
  );
}

void dismissDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop('dialog');
}

void showConfirmationDialog(BuildContext context, String title, String content,
    positiveBtnText, negativeBtnText, Function confirmCallback) {
  // flutter defined function

  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          TextButton(
            child: Text(negativeBtnText),
            onPressed: () {
              Navigator.of(context).pop();
              confirmCallback(false);
            },
          ),
          TextButton(
            child: Text(positiveBtnText),
            onPressed: () {
              Navigator.of(context).pop();
              confirmCallback(true);
            },
          )
        ],
      );
    },
  );
}
