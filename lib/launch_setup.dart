import 'package:digitalfarming/resources/app_logger.dart';
import 'package:digitalfarming/resources/auth_token_repository.dart';
import 'package:digitalfarming/resources/env_repository.dart';
import 'package:digitalfarming/resources/refresh_token_repository.dart';

mixin LaunchSetupMember {
  Future<void> load();
}

class LaunchSetup {
  final List<LaunchSetupMember> _members = [
    EnvRepository(),
    AppLogger(),
    TokenRepository(),
    RefreshTokenRepository(),
  ];

  Future<void> load() async {
    for (LaunchSetupMember member in _members) {
      await member.load();
    }
  }
}
