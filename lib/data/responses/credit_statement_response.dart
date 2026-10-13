part of "../data.dart";

class CreditStatementResponse {
  final List<CreditStatement> result;

  CreditStatementResponse({
    required this.result,
  });

  factory CreditStatementResponse.fromJson(String str) => CreditStatementResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreditStatementResponse.fromMap(Map<String, dynamic> json) => CreditStatementResponse(
    result: json["result"] == null ? <CreditStatement>[] : List<CreditStatement>.from(json["result"]!.map((dynamic x) => CreditStatement.fromMap(x))),
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "result": List<dynamic>.from(result.map((CreditStatement x) => x.toMap())),
  };
}

class CreditStatement {
  final String? id;
  final String? dueDate;
  final int? status;
  final int? creditDebt;
  final int? loanDebt;
  final int? remainCreditDebt;
  final int? remainLoanDebt;

  String statusText() {
    if (status == 1) return "باز";
    if (status == 2) return "بسته";
    if (status == 3) return "تسویه شده";
    return "---";
  }

  CreditStatement({
    this.id,
    this.dueDate,
    this.status,
    this.creditDebt,
    this.loanDebt,
    this.remainCreditDebt,
    this.remainLoanDebt,
  });

  factory CreditStatement.fromJson(String str) => CreditStatement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreditStatement.fromMap(Map<String, dynamic> json) => CreditStatement(
    id: json["id"],
    dueDate: json["dueDate"],
    status: json["status"],
    creditDebt: json["creditDebt"],
    loanDebt: json["loanDebt"],
    remainCreditDebt: json["remainCreditDebt"],
    remainLoanDebt: json["remainLoanDebt"],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "id": id,
    "dueDate": dueDate,
    "status": status,
    "creditDebt": creditDebt,
    "loanDebt": loanDebt,
    "remainCreditDebt": remainCreditDebt,
    "remainLoanDebt": remainLoanDebt,
  };



}
