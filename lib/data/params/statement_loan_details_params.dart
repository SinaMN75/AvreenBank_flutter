part of "../data.dart";

class StatementLoanDetailsParams {
  final String? billId;

  StatementLoanDetailsParams({
    this.billId,
  });

  factory StatementLoanDetailsParams.fromJson(String str) => StatementLoanDetailsParams.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatementLoanDetailsParams.fromMap(Map<String, dynamic> json) => StatementLoanDetailsParams(
    billId: json["billId"],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "billId": billId,
  };
}
