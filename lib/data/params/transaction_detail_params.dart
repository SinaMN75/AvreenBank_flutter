part of "../data.dart";

class TransactionDetailParams {
  TransactionDetailParams({
    required this.fileId,
    required this.logId,
  });

  factory TransactionDetailParams.fromJson(String str) => TransactionDetailParams.fromMap(json.decode(str));

  factory TransactionDetailParams.fromMap(Map<String, dynamic> json) => TransactionDetailParams(
    fileId: json["fileId"],
    logId: json["logId"],
  );

  final String fileId;
  final String logId;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "fileId": fileId,
    "logId": logId,
  };
}
