import 'package:digitalfarming/utils/app_theme.dart';
import 'package:flutter/material.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.1,
      width: width,
      color: const Color(0xff101a2f),
      padding: EdgeInsets.only(
          top: height * 0.04, left: width * 0.02, right: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Hi!! Enumerator',
                style: AppTheme.body3White,
              ),
              Icon(
                Icons.logout_sharp,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
