part of "../data.dart";

class AccountStatementParams {
  AccountStatementParams({
    required this.accountId,
    required this.count,
    this.endDateTime,
    this.startDateTime,
  });

  factory AccountStatementParams.fromJson(String str) => AccountStatementParams.fromMap(json.decode(str));

  factory AccountStatementParams.fromMap(dynamic json) => AccountStatementParams(
    accountId: json["accountId"],
    count: json["count"],
    endDateTime: json["endDateTime"],
    startDateTime: json["startDateTime"],
  );
  final String accountId;
  final int count;
  final String? endDateTime;
  final String? startDateTime;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "accountId": accountId,
    "count": count,
    "endDateTime": endDateTime,
    "startDateTime": startDateTime,
  };
}
