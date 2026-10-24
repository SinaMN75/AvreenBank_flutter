part of "../data.dart";

class CreditChargeHistoryResponse {
  CreditChargeHistoryResponse({required this.result});

  factory CreditChargeHistoryResponse.fromJson(String str) => CreditChargeHistoryResponse.fromMap(json.decode(str));

  factory CreditChargeHistoryResponse.fromMap(Map<String, dynamic> json) => CreditChargeHistoryResponse(
    result: json["result"] == null ? <CreditChargeLog>[] : List<CreditChargeLog>.from(json["result"]!.map((dynamic x) => CreditChargeLog.fromMap(x))),
  );
  final List<CreditChargeLog> result;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "result": List<dynamic>.from(result.map((CreditChargeLog x) => x.toMap())),
  };
}

class CreditChargeLog {
  CreditChargeLog({
    this.chargeLogId,
    this.chargeDate,
    this.requestChargeAmount,
    this.creditDebit,
    this.insDebit,
    this.chargeAmount,
    this.eventId,
    this.eventName,
  });

  factory CreditChargeLog.fromJson(String str) => CreditChargeLog.fromMap(json.decode(str));

  factory CreditChargeLog.fromMap(Map<String, dynamic> json) => CreditChargeLog(
    chargeLogId: json["chargeLogId"],
    chargeDate: json["chargeDate"],
    requestChargeAmount: json["requestChargeAmount"],
    creditDebit: json["creditDebit"],
    insDebit: json["insDebit"],
    chargeAmount: json["chargeAmount"],
    eventId: json["eventId"],
    eventName: json["eventName"],
  );
  final String? chargeLogId;
  final String? chargeDate;
  final int? requestChargeAmount;
  final int? creditDebit;
  final int? insDebit;
  final int? chargeAmount;
  final int? eventId;
  final String? eventName;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "chargeLogId": chargeLogId,
    "chargeDate": chargeDate,
    "requestChargeAmount": requestChargeAmount,
    "creditDebit": creditDebit,
    "insDebit": insDebit,
    "chargeAmount": chargeAmount,
    "eventId": eventId,
    "eventName": eventName,
  };
}
