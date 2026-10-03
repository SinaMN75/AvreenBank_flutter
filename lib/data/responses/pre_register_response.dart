part of "../data.dart";

class PreRegisterResponse {
  PreRegisterResponse({
    required this.loginToken,
    required this.otpLength,
  });

  factory PreRegisterResponse.fromJson(String str) => PreRegisterResponse.fromMap(json.decode(str));

  factory PreRegisterResponse.fromMap(Map<String, dynamic> json) =>
      PreRegisterResponse(
        loginToken: json["loginToken"],
        otpLength: json["otpLength"],
      );

  final String loginToken;
  final int otpLength;
}
