import 'dart:async';

import 'package:digitalfarming/blocs/repository/login_repository.dart';
import 'package:digitalfarming/models/login.dart';
import 'package:digitalfarming/models/registration_response.dart';
import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class LoginBloc {
  final logger = AppLogger.get('LoginBloc');
  final LoginRepository _loginRepository = LoginRepository();

  final StreamController<Result> _loginController = StreamController<Result>();

  StreamSink get loginSink => _loginController.sink;
  Stream<Result> get loginStream => _loginController.stream;

  Future<void> login(Login? data) async {
    loginSink.add(Result.loading(Constants.LOADING_LOGIN));
    final Result<RegistrationResponse> response =
        await _loginRepository.login(data!);
    loginSink.add(Result.completed(response));
  }

  void dispose() {
    _loginController.close();
  }

}
