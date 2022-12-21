import 'package:digitalfarming/blocs/client/login_client.dart';
import 'package:digitalfarming/models/login.dart';
import 'package:digitalfarming/models/registration_response.dart';
import 'package:digitalfarming/resources/api_exception.dart';
import 'package:digitalfarming/resources/auth_token_repository.dart';
import 'package:digitalfarming/resources/refresh_token_repository.dart';
import 'package:digitalfarming/resources/result.dart';

class LoginRepository {
  LoginRepository({LoginClient? client}) {
    _client = client ?? LoginClient();
  }

  LoginClient _client = LoginClient();
  final TokenRepository _tokenRepository = TokenRepository();
  final RefreshTokenRepository _refreshTokenRepository =
      RefreshTokenRepository();

  //Login Method
  Future<Result<RegistrationResponse>> login(Login login) async {
    Result<RegistrationResponse> registrationResponse =
        await _client.login(login);
    if (registrationResponse.status == Status.completed) {
      await _tokenRepository.setToken(registrationResponse.data?.auth);
      await _refreshTokenRepository.setToken(registrationResponse.data?.token);
    } else {
      _tokenRepository.deleteToken();
      throw UnauthorisedException();
    }

    return registrationResponse;
  }
}
