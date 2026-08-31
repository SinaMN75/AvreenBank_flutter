part of "../data.dart";

class AccountStatementResponse {
  AccountStatementResponse({required this.statementElementList});

  factory AccountStatementResponse.fromJson(String str) => AccountStatementResponse.fromMap(json.decode(str));

  factory AccountStatementResponse.fromMap(dynamic json) => AccountStatementResponse(
    statementElementList: List<StatementElement>.from(json["statementElementList"].map(StatementElement.fromMap)),
  );
  final List<StatementElement> statementElementList;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "statementElementList": List<dynamic>.from(statementElementList.map((StatementElement x) => x.toMap())),
  };
}

class StatementElement {
  StatementElement({
    this.accountId,
    this.accountTitle,
    this.balance,
    this.currencyCode,
    this.description,
    this.preBalance,
    this.transactionAmount,
    this.type,
    this.voucherDate,
    this.voucherId,
  });

  factory StatementElement.fromJson(String str) => StatementElement.fromMap(json.decode(str));

  factory StatementElement.fromMap(dynamic json) => StatementElement(
    accountId: json["accountId"],
    accountTitle: json["accountTitle"],
    balance: json["balance"],
    currencyCode: json["currencyCode"],
    description: json["description"],
    preBalance: json["preBalance"],
    transactionAmount: json["transactionAmount"],
    type: json["type"],
    voucherDate: json["voucherDate"],
    voucherId: json["voucherId"],
  );
  final String? accountId;
  final String? accountTitle;
  final int? balance;
  final int? currencyCode;
  final String? description;
  final int? preBalance;
  final int? transactionAmount;
  final String? type;
  final String? voucherDate;
  final String? voucherId;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "accountId": accountId,
    "accountTitle": accountTitle,
    "balance": balance,
    "currencyCode": currencyCode,
    "description": description,
    "preBalance": preBalance,
    "transactionAmount": transactionAmount,
    "type": type,
    "voucherDate": voucherDate,
    "voucherId": voucherId,
  };
}
