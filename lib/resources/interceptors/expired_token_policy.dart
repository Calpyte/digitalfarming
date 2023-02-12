import 'dart:convert';

import 'package:digitalfarming/models/token.dart';
import 'package:digitalfarming/resources/auth_token_repository.dart';
import 'package:digitalfarming/resources/env_repository.dart';
import 'package:digitalfarming/resources/refresh_token_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/models/response_data.dart';
import 'package:http_interceptor/models/retry_policy.dart';


class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int maxRetryAttempts = 1;

  final RefreshTokenRepository _refreshTokenRepository = RefreshTokenRepository();
  final TokenRepository _tokenRepository = TokenRepository();

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      final String _baseApiUrl =
          EnvRepository().getValue(key: EnvRepository.baseApiUrl);

      var url = Uri.parse(_baseApiUrl + "/unsecure/token");
      var client = http.Client();
      try {
        String refreshToken = await _refreshTokenRepository.getToken();
        var response = await http.Client().post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'token': refreshToken}),
        );
        final Token authToken = Token.fromJson(json.decode(response.body));
        _tokenRepository.deleteToken();
        _tokenRepository.setToken(authToken.token);
      } finally {
        client.close();
      }

      return true;
    }
    return false;
  }
}
