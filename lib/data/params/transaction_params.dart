part of "../data.dart";

class TransactionParams {
  TransactionParams({
    this.fileId,
  });

  factory TransactionParams.fromJson(String str) => TransactionParams.fromMap(json.decode(str));

  factory TransactionParams.fromMap(Map<String, dynamic> json) => TransactionParams(
    fileId: json["fileId"],
  );
  final String? fileId;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "fileId": fileId,
  };
}
