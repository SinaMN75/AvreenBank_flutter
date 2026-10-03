part of "../data.dart";

class RegisterParams {
  RegisterParams({
    required this.otp,
    required this.loginToken,
  });

  factory RegisterParams.fromJson(String str) => RegisterParams.fromMap(json.decode(str));

  factory RegisterParams.fromMap(Map<String, dynamic> json) => RegisterParams(
        otp: json["otp"],
        loginToken: json["loginToken"],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        "otp": otp,
        "loginToken": loginToken,
      };

  final String otp;
  final String loginToken;
}
