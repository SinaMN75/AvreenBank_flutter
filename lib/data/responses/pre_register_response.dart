part of "../data.dart";

class PreRegisterResponse {
  PreRegisterResponse({
    required this.personId,
    required this.otpLength,
  });

  factory PreRegisterResponse.fromJson(String str) => PreRegisterResponse.fromMap(json.decode(str));

  factory PreRegisterResponse.fromMap(Map<String, dynamic> json) =>
      PreRegisterResponse(
        personId: json["personId"],
        otpLength: json["otpLength"],
      );

  final String personId;
  final int otpLength;
}
