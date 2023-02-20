// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Constants {
  //Commom
  static const String APP_NAME = "Digital Farming";
  static const String TAG_LINE = "A Platform built for digital agri !!";

  //Splash and Auth
  static const LETS_STARTED = "Lets get Started";
  static const LOGIN = "Login";
  static const LOGIN_FAILED = 'Login failed';

  //Loading Message
  static const LOADING_LOGIN = 'Logging In';
  static const FARMER_REGISTRATION = "Farmer Registration";
  static const FARMER_DETAILS = "Farmer Informmation";
  static const FARMER = "Farmer";
  static const VARIETY = "Variety";
  static const PERSONAL_FARMER = "Personal Informmation";
  static const LOCATION_DETAILS = "Location Details";
  static const CROP_DETAILS = "Crop Informmation";
  static const LAND_REGISTRATION = "Land Registration";
  static const LAND_DETAIL = "Land Detail";
  static const BIN_REGISTRATION = "Bin Registration";
  static const BIN_SCREEN = "Bins";
  static const PROCUREMENT = "Procurement";
  static const PROCUREMENT_INFO = "Procurement Information";
  static const BIN_ADD = "Add To Bin";
  static const BIN_MANAGEMENT = "Bin Management";
  static const All_BINS = "All bins";

  static const INPUT_WEIGHT = "Input Weight";
  static const AMOUNT = "Amount";

  static const LOADING = 'Loading';
  static const SERVER_ERROR = 'Server Error';

  static const ADD_NEW_BIN = "Create New Bin";
  static const RECONCILE_BIN = "Reconcile Bin";
  static const CULTIVATION = "Cultivation";
  static const CULTIVATION_INFORMATION = "Cultivation Information";

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
