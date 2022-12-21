import 'package:flutter/material.dart';

class Constants {
  //Commom
  static const String APP_NAME = "Digital Farming";
  static const String TAG_LINE = "A Platform built for digital agree !!";

  //Splash and Auth
  static const LETS_STARTED = "Lets get Started";
  static const LOGIN = "Login";
  static const LOGIN_FAILED = 'Login failed';

  //Loading Message
  static const LOADING_LOGIN = 'Logging In';
  static const FARMER_REGISTRATION = "Farmer Registration";
  static const LAND_REGISTRATION = "Land Registration";
  static const BIN_REGISTRATION = "Bin Registration";
  static const CROP_TRANSACTION = "Crop Transaction";

  static const LOADING = 'Loading';
  static const SERVER_ERROR = 'Server Error';

  static Decoration withShadow() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: const Color(0xffffffff),
      boxShadow: const [
        BoxShadow(
          color: Color(0x29000000),
          offset: Offset(0, 3),
          blurRadius: 1,
        ),
      ],
    );
  }
}
