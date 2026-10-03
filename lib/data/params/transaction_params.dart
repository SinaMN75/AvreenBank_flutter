part of "../data.dart";

class TransactionParams {
  TransactionParams({
    this.count,
    this.fileId,
    this.endDateTime,
    this.startDateTime,
  });

  factory TransactionParams.fromJson(String str) => TransactionParams.fromMap(json.decode(str));

  factory TransactionParams.fromMap(Map<String, dynamic> json) => TransactionParams(
    fileId: json["fileId"],
    count: json["count"],
    endDateTime: json["endDateTime"],
    startDateTime: json["startDateTime"],
  );

  final String? fileId;
  final int? count;
  final String? endDateTime;
  final String? startDateTime;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "fileId": fileId,
    "count": count,
    "endDateTime": endDateTime,
    "startDateTime": startDateTime,
  };
}
