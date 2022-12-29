import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ShadowCard extends StatelessWidget {
  const ShadowCard({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      decoration: Constants.withShadow(),
      margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
      padding: EdgeInsets.only(
          left: width * 0.05, right: width * 0.05, bottom: height * 0.02),
      child: Column(
        children: children,
      ),
    );
  }
}
