import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;
  const AppLogo({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage('assets/images/logo.png'),
      width: width,
      height: height,
    );
  }
}
