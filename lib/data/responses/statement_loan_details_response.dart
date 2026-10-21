part of "../data.dart";

class StatementLoanDetailsResponse {
  final List<StatementLoanDetail> result;

  StatementLoanDetailsResponse({
    required this.result,
  });

  factory StatementLoanDetailsResponse.fromJson(String str) => StatementLoanDetailsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatementLoanDetailsResponse.fromMap(Map<String, dynamic> json) => StatementLoanDetailsResponse(
    result: json["result"] == null ? <StatementLoanDetail>[] : List<StatementLoanDetail>.from(json["result"]!.map((dynamic x) => StatementLoanDetail.fromMap(x))),
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "result": List<dynamic>.from(result.map((StatementLoanDetail x) => x.toMap())),
  };
}

class StatementLoanDetail {
  final String? id;
  final String? date;
  final int? totalAmount;
  final int? instalmentCount;
  final int? loanDebt;
  final String? description;
  final int? payStatus;

  StatementLoanDetail({
    this.id,
    this.date,
    this.totalAmount,
    this.instalmentCount,
    this.loanDebt,
    this.description,
    this.payStatus,
  });

  factory StatementLoanDetail.fromJson(String str) => StatementLoanDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatementLoanDetail.fromMap(Map<String, dynamic> json) => StatementLoanDetail(
    id: json["id"],
    date: json["date"],
    totalAmount: json["totalAmount"],
    instalmentCount: json["instalmentCount"],
    loanDebt: json["loanDebt"],
    description: json["description"],
    payStatus: json["payStatus"],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "id": id,
    "date": date,
    "totalAmount": totalAmount,
    "instalmentCount": instalmentCount,
    "loanDebt": loanDebt,
    "description": description,
    "payStatus": payStatus,
  };
}
