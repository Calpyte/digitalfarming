import 'package:digitalfarming/screen/splash_screen.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'launch_setup.dart';

Future<void> main() async {
  await LaunchSetup().load();
  runApp(const DigitalFarming());
}

class DigitalFarming extends StatelessWidget {
  const DigitalFarming({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF6F6FB),
        appBarTheme: const AppBarTheme(
          iconTheme: AppTheme.iconTheme,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        textTheme: AppTheme.textTheme,
        tabBarTheme: AppTheme.tabBarTheme,
      ),
      home: const SplashScreen(),
    );
  }
}
