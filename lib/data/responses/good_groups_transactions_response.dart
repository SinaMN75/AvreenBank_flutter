part of "../data.dart";

class GoodGroupsTransactionsResponse {
  GoodGroupsTransactionsResponse({
    this.result = const <GoodGroupTransaction>[],
  });

  factory GoodGroupsTransactionsResponse.fromJson(String str) => GoodGroupsTransactionsResponse.fromMap(json.decode(str));

  factory GoodGroupsTransactionsResponse.fromMap(Map<String, dynamic> json) => GoodGroupsTransactionsResponse(
    result: json["result"] == null ? <GoodGroupTransaction>[] : List<GoodGroupTransaction>.from(json["result"].map(GoodGroupTransaction.fromMap)),
  );

  final List<GoodGroupTransaction> result;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "result": List<dynamic>.from(result.map((GoodGroupTransaction x) => x.toMap())),
  };
}

class GoodGroupTransaction {
  GoodGroupTransaction({
    this.transactionId,
    this.useWeight,
    this.logDate,
    this.oldWeight,
    this.newWeight,
    this.cacheBack,
  });

  factory GoodGroupTransaction.fromJson(String str) => GoodGroupTransaction.fromMap(json.decode(str));

  factory GoodGroupTransaction.fromMap(dynamic json) => GoodGroupTransaction(
    transactionId: json["transactionId"],
    useWeight: (json["useWeight"] as num?)?.toInt(),
    logDate: json["logDate"],
    oldWeight: (json["oldWeight"] as num?)?.toInt(),
    newWeight: (json["newWeight"] as num?)?.toInt(),
    cacheBack: (json["cacheBack"] as num?)?.toInt(),
  );

  final String? transactionId;
  final int? useWeight;
  final String? logDate;
  final int? oldWeight;
  final int? newWeight;
  final int? cacheBack;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "transactionId": transactionId,
    "useWeight": useWeight,
    "logDate": logDate,
    "oldWeight": oldWeight,
    "newWeight": newWeight,
    "cacheBack": cacheBack,
  };
}
