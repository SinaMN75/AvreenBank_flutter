part of "../data.dart";

class RegisterParams {
  RegisterParams({
    required this.otp,
    required this.personId,
  });

  factory RegisterParams.fromJson(String str) => RegisterParams.fromMap(json.decode(str));

  factory RegisterParams.fromMap(Map<String, dynamic> json) => RegisterParams(
        otp: json["otp"],
        personId: json["personId"],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        "otp": otp,
        "personId": personId,
      };

  final String otp;
  final String personId;
}
