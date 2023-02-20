import 'package:digitalfarming/screen/settings_screen.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/routes.dart';
import 'package:digitalfarming/views/profile/card_menu.dart';
import 'package:digitalfarming/views/profile/profile_data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
        actions: [
          IconButton(
            onPressed: () {
              AppRouter.removeAllAndPush(context, SettingsScreen.routeName);
            },
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: ListView(
        children: const [
          ProfileData(),
          CardMenu(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: EdgeInsets.only(left: width * 0.2, bottom: 10),
        child: Center(
          child: Row(
            children: const [
              Icon(Icons.copyright),
              Text('Powered By, Calpyte Technologies'),
            ],
          ),
        ),
      ),
    );
  }
}
