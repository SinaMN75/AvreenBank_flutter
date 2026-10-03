part of "../data.dart";

class PreRegisterParams {
  PreRegisterParams({
    required this.loginMode,
    required this.nationalId,
    required this.mobileNo,
    this.organizationId,
    this.personnelCode,
  });

  factory PreRegisterParams.fromJson(String str) => PreRegisterParams.fromMap(json.decode(str));

  factory PreRegisterParams.fromMap(Map<String, dynamic> json) => PreRegisterParams(
    loginMode: json["loginMode"],
    nationalId: json["nationalId"],
    mobileNo: json["mobileNo"],
    organizationId: json["organizationId"],
    personnelCode: json["personnelCode"],
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "loginMode": loginMode,
    "nationalId": nationalId,
    "mobileNo": mobileNo,
    "organizationId": organizationId,
    "personnelCode": personnelCode,
  };

  final int loginMode;
  final String nationalId;
  final String mobileNo;
  final String? organizationId;
  final String? personnelCode;
}
