part of "../data.dart";

class StatementCreditDetailsResponse {
  final List<StatementCreditDetail> result;

  StatementCreditDetailsResponse({
    required this.result,
  });

  factory StatementCreditDetailsResponse.fromJson(String str) => StatementCreditDetailsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatementCreditDetailsResponse.fromMap(Map<String, dynamic> json) => StatementCreditDetailsResponse(
    result: json["result"] == null ? <StatementCreditDetail>[] : List<StatementCreditDetail>.from(json["result"]!.map((dynamic x) => StatementCreditDetail.fromMap(x))),
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "result": List<dynamic>.from(result.map((StatementCreditDetail x) => x.toMap())),
  };
}

class StatementCreditDetail {
  final String? docId;
  final String? date;
  final int? amount;
  final String? description;

  StatementCreditDetail({
    this.docId,
    this.date,
    this.amount,
    this.description,
  });

  factory StatementCreditDetail.fromJson(String str) => StatementCreditDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatementCreditDetail.fromMap(Map<String, dynamic> json) => StatementCreditDetail(
    docId: json["docId"],
    date: json["date"],
    amount: json["amount"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "docId": docId,
    "date": date,
    "amount": amount,
    "description": description,
  };
}
