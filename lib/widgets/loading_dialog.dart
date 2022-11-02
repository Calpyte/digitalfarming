import 'package:digitalfarming/views/loading_progress_indicator.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final Alignment alignment = Alignment.center;
  final double width = 36.0;
  final double height = 36.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        color: Colors.black54,
        child: Container(
          alignment: alignment,
          width: width,
          height: height,
          child: const LoadingProgressIndicator(),
        ),
      ),
    );
  }
}
