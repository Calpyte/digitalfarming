import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/api_response_codes.dart';
import 'package:digitalfarming/resources/interceptors/expired_token_policy.dart';
import 'package:digitalfarming/resources/interceptors/log_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import 'auth_interceptor.dart';
import 'auth_token_repository.dart';
import 'env_repository.dart';
import 'platform_info_repository.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiBaseHelper {
  ApiBaseHelper({
    InterceptedClient? client,
    InterceptedClient? clientWithAuth,
    PlatformInfoRespository? platformInfoRespository,
  }) {
    httpClientWithAuth.requestTimeout = _requestTimeOut;
    httpClient.requestTimeout = _requestTimeOut;
  }

  @visibleForTesting
  InterceptedClient httpClientWithAuth = InterceptedClient.build(
    interceptors: [
      AuthInterceptor(
        TokenRepository(),
      ),
      LogInterceptor(),
    ],
    retryPolicy: ExpiredTokenRetryPolicy(),
  );

  @visibleForTesting
  InterceptedClient httpClient = InterceptedClient.build(
    interceptors: [
      LogInterceptor(),
    ],
  );

  PlatformInfoRespository _platformInfoRespository =
      PlatformInfoRespositoryImpl();
  final _requestTimeOut = const Duration(seconds: 20);

  final String _baseApiUrl =
      EnvRepository().getValue(key: EnvRepository.baseApiUrl);

  InterceptedClient _client(bool authenticated) =>
      authenticated ? httpClientWithAuth : httpClient;

  Future<String> getPlatformHeader() async {
    final platformInfo = _platformInfoRespository.getPlatformInfo();
    //return '${platformInfo?.appName}/${platformInfo?.version}(${platformInfo?.buildNumber})/${platformInfo?.platformOS}/${platformInfo?.platformOSVersion}';
    return '${platformInfo?.appName}/${platformInfo?.version}(${platformInfo?.buildNumber})/${Platform.operatingSystem}/${Platform.operatingSystemVersion}';
  }

  Future<dynamic> get(String path, {bool authenticated = true}) async {
    final String platformHeader = await getPlatformHeader();
    final String? deviceId = await _getId();
    var url = Uri.parse(_baseApiUrl + path);
    try {
      final response = await _client(authenticated).get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-platform': platformHeader,
          'x-uid': deviceId ?? ""
        },
      );
      return _getResponseBody(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw ConnectionTimeoutException('Connection timed out');
    }
  }

  Future<dynamic> put(bool authenticated, String path, dynamic body) async {
    final String platformHeader = await getPlatformHeader();
    final String? deviceId = await _getId();
    var url = Uri.parse(_baseApiUrl + path);
    try {
      final response = await _client(authenticated).put(url,
          headers: {
            'Content-Type': 'application/json',
            'x-wstexchng-platform': platformHeader,
            'x-uid': deviceId ?? ""
          },
          body: json.encode(body));
      return _getResponseBody(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw ConnectionTimeoutException('Connection timed out');
    }
  }

  Future<dynamic> post(bool authenticated, String path, dynamic body) async {
    final String platformHeader = await getPlatformHeader();
    final String? deviceId = await _getId();
    var url = Uri.parse(_baseApiUrl + path);
    try {
      final response = await _client(authenticated).post(url,
          headers: {
            'Content-Type': 'application/json',
            'x-wstexchng-platform': platformHeader,
            'x-uid': deviceId ?? ""
          },
          body: json.encode(body));
      return _getResponseBody(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw ConnectionTimeoutException('Connection timed out');
    }
  }

  Future<dynamic> uploadFile(
      bool authenticated, XFile? pickedFile, String path) async {
    final String platformHeader = await getPlatformHeader();
    final String? deviceId = await _getId();
    var url = Uri.parse(_baseApiUrl + path);

    final mimeTypeData =
        lookupMimeType(pickedFile!.path, headerBytes: [0xFF, 0xD8])!.split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'image',
      pickedFile.path,
      contentType: MediaType(
        mimeTypeData[0],
        mimeTypeData[1],
      ),
    );

    imageUploadRequest.files.add(file);
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _getResponseBody(response);
    } catch (e) {
      print(e);
    }
  }

  bool _isSuccessfulResponse(Response response) {
    return APIResponseCodes.ok <= response.statusCode &&
        response.statusCode < APIResponseCodes.multipleChoices;
  }

  dynamic _getResponseBody(Response response) {
    final String responseStr = response.body.toString();
    if (_isSuccessfulResponse(response)) {
      return responseStr;
    }
    handleUnsuccessfulStatusCode(response, responseStr);
  }

  void handleUnsuccessfulStatusCode(Response response, String responseStr) {
    switch (response.statusCode) {
      case APIResponseCodes.badRequest:
        final ApiException exception = BadRequestException(responseStr);
        // logger.e(exception);
        throw exception;
      case APIResponseCodes.unauthorized:
      case APIResponseCodes.forbidden:
        final ApiException exception = UnauthorisedException(responseStr);
        //  logger.e(exception);
        throw exception;
      case APIResponseCodes.notFound:
        final ApiException exception = ResourceNotFoundException(responseStr);
        //  logger.e(exception);
        throw exception;
      case APIResponseCodes.internalServerError:
      default:
        final ApiException exception = FetchDataException(
            'Error occured while communicating with server. StatusCode : ${response.statusCode}, Error: $responseStr');
        //  logger.e(exception);
        throw exception;
    }
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return "";
  }
}
