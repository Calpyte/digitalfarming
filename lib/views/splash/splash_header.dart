import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashHeader extends StatefulWidget {
  const SplashHeader({Key? key}) : super(key: key);

  @override
  State<SplashHeader> createState() => _SplashHeaderState();
}

class _SplashHeaderState extends State<SplashHeader> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff101a2f),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(100.0),
          bottomLeft: Radius.circular(100.0),
        ),
        border: Border.all(width: 1.0, color: const Color(0xff707070)),
      ),
      padding: EdgeInsets.fromLTRB(0.0, height * 0.2, 0.0, 0),
      height: height * 0.5,
      width: width,
      child: Column(
        children: const [
          Text(
            Constants.APP_NAME,
            style: AppTheme.body1White,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            Constants.TAG_LINE,
            style: AppTheme.body3White,
          ),
        ],
      ),
    );
  }
}
