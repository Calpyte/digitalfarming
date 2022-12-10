import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:flutter/material.dart';

class BinRegistrationScreen extends StatefulWidget {
  static const routeName = '/bin-registration';
  const BinRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<BinRegistrationScreen> createState() => _BinRegistrationScreenState();
}

class _BinRegistrationScreenState extends State<BinRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.BIN_REGISTRATION,
          style: AppTheme.body,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
