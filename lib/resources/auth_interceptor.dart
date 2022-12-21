import 'package:digitalfarming/resources/api_response_codes.dart';
import 'package:digitalfarming/resources/refresh_token_repository.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'auth_token_repository.dart';

/// Interceptor that modify API Request by adding authentication information to the request.
class AuthInterceptor implements InterceptorContract {
  AuthInterceptor(TokenRepository tokenRepository) {
    _tokenRepository = tokenRepository;
  }

  TokenRepository _tokenRepository = TokenRepository();
  final RefreshTokenRepository _refreshTokenRepository =
      RefreshTokenRepository();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    final String token = await _tokenRepository.getToken();
    data.headers['Authorization'] = 'Bearer $token';
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == APIResponseCodes.unauthorized ||
        data.statusCode == APIResponseCodes.forbidden) {
      await _tokenRepository.deleteToken();
      await _refreshTokenRepository.deleteToken();
    }
    return data;
  }
}
