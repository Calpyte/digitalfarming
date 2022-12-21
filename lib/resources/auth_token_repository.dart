import 'package:digitalfarming/launch_setup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenRepository implements LaunchSetupMember {
  factory TokenRepository() {
    return _singleton;
  }

  factory TokenRepository.testInit(
      [FlutterSecureStorage? cachedSecureStorage]) {
    return TokenRepository._internal(cachedSecureStorage);
  }

  TokenRepository._internal([FlutterSecureStorage? cachedSecureStorage]) {
    _cachedSecureStorage = cachedSecureStorage ?? const FlutterSecureStorage();
  }

  static final TokenRepository _singleton = TokenRepository._internal();
  static const _ktoken = 'token';

  FlutterSecureStorage _cachedSecureStorage = const FlutterSecureStorage();
  String token = '';

  bool isAuthorized() {
    getToken();
    return token != null && token != '';
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

}
