class RegistrationResponse {
  RegistrationResponse({
    this.id,
    this.success,
    this.message,
    this.auth,
    this.token,
    this.userType
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationResponse(
        id: json['id'],
        success: json['success'],
        message: json['message'],
        auth: json['auth'],
        token: json['token'],
        userType: json['userType'],
      );

  String? id;
  String? success;
  String? message;
  String? auth;
  String? token;
  String? userType;
}
