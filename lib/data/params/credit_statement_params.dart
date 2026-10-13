part of "../data.dart";

class CreditStatementParams {
  final String? accountId;
  final int? count;
  final String? startDateTime;
  final String? endDateTime;

  CreditStatementParams({
    this.accountId,
    this.count,
    this.startDateTime,
    this.endDateTime,
  });

  factory CreditStatementParams.fromJson(String str) => CreditStatementParams.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreditStatementParams.fromMap(Map<String, dynamic> json) => CreditStatementParams(
    accountId: json["accountId"],
    count: json["count"],
    startDateTime: json["startDateTime"],
    endDateTime: json["endDateTime"],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "accountId": accountId,
    "count": count,
    "startDateTime": startDateTime,
    "endDateTime": endDateTime,
  };
}