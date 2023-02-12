import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CultivationScreen extends StatefulWidget {
  static const routeName = '/cultivation';
  const CultivationScreen({Key? key}) : super(key: key);

  @override
  State<CultivationScreen> createState() => _CultivationScreenState();
}

class _CultivationScreenState extends State<CultivationScreen> {
  UIState _uiState = UIState.loading;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  initState() {
    getMasters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.CULTIVATION,
          style: AppTheme.body,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [],
      ),
    );
  }

  getMasters() {

  }
}
