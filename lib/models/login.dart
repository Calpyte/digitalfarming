class Login {
  Login({
    required this.userName,
    required this.password,
  });
  late final String userName;
  late final String password;

  Login.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userName'] = userName;
    data['password'] = password;
    return data;
  }
}
