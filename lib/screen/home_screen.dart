import 'package:digitalfarming/utils/app_colors.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/views/profile/card_menu.dart';
import 'package:digitalfarming/views/profile/profile_data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.APP_NAME,
          style: AppTheme.body,
        ),
        leading: Image.asset(
          'assets/images/logo.png',
          height: 100,
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: ListView(
        children: const [
          ProfileData(),
          CardMenu(),
        ],
      ),
    );
  }
}
