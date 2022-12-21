import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../launch_setup.dart';


abstract class PlatformInfoRespository {
  PackageInfo? getPlatformInfo();
  DeviceInfoPlugin? getDeviceInfo();
}

class PlatformInfoRespositoryImpl
    implements PlatformInfoRespository, LaunchSetupMember {
  factory PlatformInfoRespositoryImpl() {
    return _singleton;
  }

  PlatformInfoRespositoryImpl._internal();

  static final PlatformInfoRespositoryImpl _singleton =
      PlatformInfoRespositoryImpl._internal();

  PackageInfo? _platformInfo;
  DeviceInfoPlugin? _deviceInfo;

  @override
  PackageInfo? getPlatformInfo() => _platformInfo;

  @override
  DeviceInfoPlugin? getDeviceInfo() => _deviceInfo;

  @override
  Future<void> load() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String appName = packageInfo.appName;
    final String appVersion = packageInfo.version;
    final String appBuildNumber = packageInfo.buildNumber;
    final packageName = packageInfo.packageName;

    _platformInfo = PackageInfo(
      appName: appName,
      buildNumber: appBuildNumber,
      version: appVersion,
      packageName: packageName,
    );

    _deviceInfo = DeviceInfoPlugin();
  }

}
