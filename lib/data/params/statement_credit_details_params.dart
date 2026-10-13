part of "../data.dart";

class StatementCreditDetailsParams {
  final String? accountId;
  final String? billId;

  StatementCreditDetailsParams({
    this.accountId,
    this.billId,
  });

  factory StatementCreditDetailsParams.fromJson(String str) => StatementCreditDetailsParams.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatementCreditDetailsParams.fromMap(Map<String, dynamic> json) => StatementCreditDetailsParams(
    accountId: json["accountId"],
    billId: json["billId"],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "accountId": accountId,
    "billId": billId,
  };
}
