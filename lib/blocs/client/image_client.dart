import 'dart:convert';

import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/api_base_helper.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class ImageClient {

  ImageClient([ApiBaseHelper? helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  ApiBaseHelper? _helper;

  static const saveImagePath = '/file/save';

  Future<Result<String>> savePhoto({required XFile photo}) async {
    try {
      dynamic imageUpload = await _helper?.uploadFile(true, photo, saveImagePath);
      Basic basic = Basic.fromJson(json.decode(imageUpload));
      return Result.completed(basic.id);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(Constants.SERVER_ERROR);
    }
  }

}