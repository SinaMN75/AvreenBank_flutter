part of "../data.dart";

class TransactionParams {
  TransactionParams({
    this.fileId,
    this.transactionStatus,
    this.transactionType,
    this.hostMerchantId,
    this.hostTerminalId,
  });

  factory TransactionParams.fromJson(String str) => TransactionParams.fromMap(json.decode(str));

  factory TransactionParams.fromMap(Map<String, dynamic> json) => TransactionParams(
    fileId: json["fileId"],
    transactionStatus: json["transactionStatus"],
    transactionType: json["transactionType"],
    hostMerchantId: json["hostMerchantId"],
    hostTerminalId: json["hostTerminalId"],
  );
  final String? fileId;
  final String? transactionStatus;
  final String? transactionType;
  final String? hostMerchantId;
  final String? hostTerminalId;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "fileId": fileId,
    "transactionStatus": transactionStatus,
    "transactionType": transactionType,
    "hostMerchantId": hostMerchantId,
    "hostTerminalId": hostTerminalId,
  };
}
