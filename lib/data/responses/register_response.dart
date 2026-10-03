part of "../data.dart";

class RegisterResponse {
  RegisterResponse({
    this.token,
    this.personId,
  });

  factory RegisterResponse.fromJson(String str) => RegisterResponse.fromMap(json.decode(str));

  factory RegisterResponse.fromMap(Map<String, dynamic> json) => RegisterResponse(
    token: json["token"],
    personId: json["personId"],
  );

  final String? token;
  final String? personId;
}
