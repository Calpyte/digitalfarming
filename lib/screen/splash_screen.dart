import 'package:digitalfarming/resources/auth_token_repository.dart';
import 'package:digitalfarming/screen/home_screen.dart';
import 'package:digitalfarming/utils/routes.dart';
import 'package:digitalfarming/views/splash/splash_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAuthorized() => TokenRepository().isAuthorized();

  @override
  initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        afterSplash();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashCard(),
    );
  }

  afterSplash() async {
    requestPermission();
    if (isAuthorized()) {
      AppRouter.removeAllAndPush(context, HomeScreen.routeName);
    }
  }

  Future<void> requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
      Permission.storage
    ].request();

    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
    } else {}
  }

}
