part of "../data.dart";

class CreditChargeHistoryParams {
  CreditChargeHistoryParams({
    required this.accountId,
    required this.orderBy,
    this.startDate,
    this.endDate,
  });

  factory CreditChargeHistoryParams.fromJson(String str) => CreditChargeHistoryParams.fromMap(json.decode(str));

  factory CreditChargeHistoryParams.fromMap(dynamic json) => CreditChargeHistoryParams(
    accountId: json["accountId"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    orderBy: json["orderBy"],
  );
  final String accountId;
  final String? startDate;
  final String? endDate;
  final bool orderBy;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "accountId": accountId,
    "startDate": startDate,
    "endDate": endDate,
    "orderBy": orderBy,
  };
}
