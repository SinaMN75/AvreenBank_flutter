part of "../data.dart";

class FaraBalanceResponse {
  FaraBalanceResponse({
    required this.nationalCode,
    this.familyCount,
    this.balance,
    this.alertMessage,
  });

  factory FaraBalanceResponse.fromJson(String str) => FaraBalanceResponse.fromMap(json.decode(str));

  factory FaraBalanceResponse.fromMap(dynamic json) => FaraBalanceResponse(
    familyCount: json["familyCount"],
    balance: json["balance"],
    nationalCode: json["nationalCode"],
    alertMessage: json["alertMessage"],
  );

  final int? balance;
  final int? familyCount;
  final String? nationalCode;
  final String? alertMessage;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "familyCount": familyCount,
    "balance": balance,
    "nationalCode": nationalCode,
    "alertMessage": alertMessage,
  };
}
