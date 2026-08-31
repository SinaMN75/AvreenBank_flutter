part of "../data.dart";

class AccountStatementParams {
  AccountStatementParams({
    required this.accountId,
    required this.count,
    this.functionCode,
    this.subFunctionCode,
    this.endDateTime,
    this.startDateTime,
  });

  factory AccountStatementParams.fromJson(String str) => AccountStatementParams.fromMap(json.decode(str));

  factory AccountStatementParams.fromMap(dynamic json) => AccountStatementParams(
    accountId: json["accountId"],
    functionCode: json["accountId"],
    subFunctionCode: json["accountId"],
    count: json["count"],
    endDateTime: json["endDateTime"],
    startDateTime: json["startDateTime"],
  );
  final String accountId;
  final String? functionCode;
  final String? subFunctionCode;
  final int count;
  final String? endDateTime;
  final String? startDateTime;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "accountId": accountId,
    "functionCode": functionCode,
    "subFunctionCode": subFunctionCode,
    "count": count,
    "endDateTime": endDateTime,
    "startDateTime": startDateTime,
  };
}
