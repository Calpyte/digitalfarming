import 'package:digitalfarming/screen/auth/login_screen.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/routes.dart';
import 'package:digitalfarming/widgets/border_button.dart';
import 'package:flutter/material.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderButton(
      onPressed: () => AppRouter.pushNamed(context, LoginScreen.routeName),
      text: Constants.LOGIN,
    );
  }
}
