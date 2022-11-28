import 'package:digitalfarming/blocs/login_bloc.dart';
import 'package:digitalfarming/models/login.dart';
import 'package:digitalfarming/screen/home_screen.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/utils/routes.dart';
import 'package:digitalfarming/widgets/app_logo.dart';
import 'package:digitalfarming/widgets/password_text_field.dart';
import 'package:digitalfarming/widgets/user_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../resources/result.dart';
import '../../widgets/border_button.dart';
import '../../widgets/dialog/dialog_util.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/loginScreen';

  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: width * 0.05,
          right: width * 0.05,
        ),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: height * 0.2),
              Container(
                margin: EdgeInsets.only(left: width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppLogo(width: width * 0.3, height: height * 0.1),
                    const Text(
                      Constants.APP_NAME,
                      style: AppTheme.body,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
              UserTextField(
                name: 'userName',
                hintText: 'User Name',
                validators: [
                  FormBuilderValidators.required(
                    errorText: 'Username Should not be empty',
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              PasswordTextField(
                name: 'password',
                hintText: 'Password',
                validators: [
                  FormBuilderValidators.required(
                    errorText: 'Password Should not be empty',
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              BorderButton(
                onPressed: () => validateAndLogin(context),
                text: Constants.LOGIN,
              ),
            ],
          ),
        ),
      ),
    );
  }


  validateAndLogin(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? true) {
      Map<String, dynamic>? userValueMap = _formKey.currentState?.value;
      Login login = Login.fromJson(userValueMap!);
      loginBloc.login(login);
      processLoginBloc(context);
    }
  }

  void processLoginBloc(BuildContext context)  {
    loginBloc.loginStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.loading:
          showLoadingDialog(context);
          break;
        case Status.error:
          dismissDialog(context);
          break;
        case Status.completed:
          dismissDialog(context);
          AppRouter.removeAllAndPush(context, HomeScreen.routeName);
          break;
      }
    });
  }



}
