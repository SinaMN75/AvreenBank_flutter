part of "../data.dart";

class PreRegisterParams {
  PreRegisterParams({
    required this.loginMode,
    required this.nationalId,
    this.organizationId,
    this.personnelCode,
  });

  factory PreRegisterParams.fromJson(String str) => PreRegisterParams.fromMap(json.decode(str));

  factory PreRegisterParams.fromMap(Map<String, dynamic> json) => PreRegisterParams(
    loginMode: json["loginMode"],
    nationalId: json["nationalId"],
    organizationId: json["organizationId"],
    personnelCode: json["personnelCode"],
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "loginMode": loginMode,
    "nationalId": nationalId,
    "organizationId": organizationId,
    "personnelCode": personnelCode,
  };

  final int loginMode;
  final String nationalId;
  final String? organizationId;
  final String? personnelCode;
}
