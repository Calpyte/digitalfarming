import 'package:digitalfarming/utils/app_theme.dart';
import 'package:flutter/material.dart';

class BorderButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const BorderButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
      width: width * 0.8,
      height: height * 0.06,
      child: OutlinedButton(
        onPressed: onPressed,
        style: AppTheme.borderStyle,
        child: Text(
          text,
        ),
      ),
    );
  }
}
