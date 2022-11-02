import 'dart:convert';
import 'package:digitalfarming/models/login.dart';
import 'package:digitalfarming/models/registration_response.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';

class LoginClient{
  LoginClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  ApiBaseHelper? _helper;

  static const pathLogin = '/unsecure/access/token';


  Future<Result<RegistrationResponse>> login(Login data) async {
    try {
      final String response =
      await _helper?.post(false, pathLogin, data.toJson());
      final registrationResponse =
      RegistrationResponse.fromJson(json.decode(response));
      return Result.completed(registrationResponse);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.LOGIN_FAILED);
    }
  }

}