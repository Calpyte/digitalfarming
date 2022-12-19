import 'package:digitalfarming/screen/bin_registration_screen.dart';
import 'package:digitalfarming/screen/farmer_registration_screen.dart';
import 'package:digitalfarming/screen/home_screen.dart';
import 'package:digitalfarming/screen/land_registration_screen.dart';
import 'package:flutter/material.dart';

import '../screen/auth/login_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case FarmerRegistrationScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const FarmerRegistrationScreen(),
        );
      case LandRegistrationScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const LandRegistrationScreen(),
        );
      case BinRegistrationScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const BinRegistrationScreen(),
        );

      default:
        return null;
    }
  }

  static void pushReplacementNamed(BuildContext context, String routeName,
      {dynamic arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static void pushNamed(BuildContext context, String routeName,
      {dynamic arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void popToRootAndPushNamed(BuildContext context, String routeName,
      {dynamic arguments}) {
    popToRoot(context);
    pushNamed(context, routeName, arguments: arguments);
  }

  static void popAndPushNamed(BuildContext context, String routeName,
      {dynamic arguments}) {
    Navigator.popAndPushNamed(context, routeName, arguments: arguments);
  }

  static void removeAllAndPush(BuildContext context, String routeName,
      {dynamic arguments}) {
    Navigator.pushNamedAndRemoveUntil(
        context, routeName, (Route<dynamic> route) => false);
  }

  static void removeAllAndPopToHome(BuildContext context, {dynamic arguments}) {
    Navigator.pushNamedAndRemoveUntil(
        context, Navigator.defaultRouteName, (Route<dynamic> route) => false);
  }

  static void popToRoot(BuildContext context, {dynamic arguments}) {
    Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName));
  }
}
