import 'package:logger/logger.dart';

import '../launch_setup.dart';
import '../resources/env_repository.dart';

class AppLogger implements LaunchSetupMember {
  Level _getLoggerLevel(String level) {
    switch (level) {
      case 'debug':
        return Level.debug;
      case 'info':
        return Level.info;
      case 'warning':
        return Level.warning;
      case 'error':
        return Level.error;
      default:
        return Level.error;
    }
  }

  static Logger get(String className) {
    return Logger(printer: PrettyPrinter(colors: true));
  }

  @override
  Future<void> load() async {
    Logger.level = _getLoggerLevel(
      EnvRepository().getValue(
        key: EnvRepository.loggerLevel,
      ),
    );
  }
}
