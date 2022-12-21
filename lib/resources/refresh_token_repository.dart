import 'package:digitalfarming/launch_setup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RefreshTokenRepository implements LaunchSetupMember {
  factory RefreshTokenRepository() {
    return _singleton;
  }

  factory RefreshTokenRepository.testInit(
      [FlutterSecureStorage? cachedSecureStorage]) {
    return RefreshTokenRepository._internal(cachedSecureStorage);
  }

  RefreshTokenRepository._internal([FlutterSecureStorage? cachedSecureStorage]) {
    _cachedSecureStorage = cachedSecureStorage ?? FlutterSecureStorage();
  }

  static final RefreshTokenRepository _singleton = RefreshTokenRepository._internal();
  static const _ktoken = 'refresh_token';

  FlutterSecureStorage _cachedSecureStorage = FlutterSecureStorage();
  String token = '';

  bool isAuthorized() {
    return token != null;
  }

  Future<void> setToken(token) async {
    this.token = token;
    await _cachedSecureStorage.write(key: _ktoken, value: token);
  }

  Future<void> deleteToken() async {
    await _cachedSecureStorage.delete(key: _ktoken);
  }

  Future<String> getToken() async {
    bool isExist = await _cachedSecureStorage.containsKey(key: _ktoken);
    if (isExist) {
      token = (await _cachedSecureStorage.read(key: _ktoken)) ?? '';
    }
    return token;
  }

  @override
  Future<void> load() async {
    await getToken();
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}
