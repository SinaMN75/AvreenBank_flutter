part of "../data.dart";

class RegisterResponse {
  RegisterResponse({
    this.token,
    this.otpLength,
    this.userName,
  });

  factory RegisterResponse.fromJson(String str) => RegisterResponse.fromMap(json.decode(str));

  factory RegisterResponse.fromMap(Map<String, dynamic> json) => RegisterResponse(
    token: json["token"],
    otpLength: json["otpLength"],
    userName: json["userName"],
  );

  final String? token;
  final int? otpLength;
  final String? userName;
}
