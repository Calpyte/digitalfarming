import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../launch_setup.dart';

class EnvRepository implements LaunchSetupMember {
  factory EnvRepository() {
    return _singleton;
  }

  EnvRepository._internal([DotEnv? env]) {
    _env = env ?? DotEnv();
  }

  static final EnvRepository _singleton = EnvRepository._internal();

  static const loggerLevel = 'LOGGER_LEVEL';
  static const baseApiUrl = 'BASE_API_URL';

  DotEnv _env = DotEnv();

  @override
  Future<void> load() async {
    await _env.load(fileName: '.env');
  }

  dynamic getValue({required String key}) {
    return _env.env[key];
  }
}
