part of "../data.dart";

class TransactionResponse {
  TransactionResponse({
    required this.transactionInfoList,
  });

  factory TransactionResponse.fromJson(String str) => TransactionResponse.fromMap(json.decode(str));

  factory TransactionResponse.fromMap(Map<String, dynamic> json) => TransactionResponse(
    transactionInfoList: List<TransactionInfo>.from(json["transactionInfoList"].map(TransactionInfo.fromMap)),
  );
  final List<TransactionInfo> transactionInfoList;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "transactionInfoList": List<dynamic>.from(transactionInfoList.map((TransactionInfo x) => x.toMap())),
  };
}

class TransactionInfo {
  TransactionInfo({
    this.debitType,
    this.docId,
    this.fileId,
    this.logDate,
    this.logId,
    this.logMessage,
    this.merchantAddress,
    this.merchantName,
    this.rrn,
    this.stan,
    this.terminalType,
    this.transactionAmount,
    this.transactionStatus,
    this.transactionType,
    this.panId,
  });

  factory TransactionInfo.fromJson(String str) => TransactionInfo.fromMap(json.decode(str));

  factory TransactionInfo.fromMap(dynamic json) => TransactionInfo(
    debitType: json["debitType"],
    docId: json["docId"],
    fileId: json["fileId"],
    logDate: json["logDate"],
    logId: json["logId"],
    logMessage: json["logMessage"],
    merchantAddress: json["merchantAddress"],
    merchantName: json["merchantName"],
    rrn: json["rrn"],
    stan: json["stan"],
    terminalType: json["terminalType"],
    transactionAmount: json["transactionAmount"],
    transactionStatus: json["transactionStatus"],
    transactionType: json["transactionType"],
    panId: json["panId"],
  );
  final String? docId;
  final String? fileId;
  final String? logDate;
  final String? logId;
  final String? logMessage;
  final String? merchantAddress;
  final String? merchantName;
  final String? rrn;
  final String? stan;
  final String? terminalType;
  final String? transactionType;
  final int? debitType;
  final int? transactionAmount;
  final int? transactionStatus;
  final String? panId;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "debitType": debitType,
    "docId": docId,
    "fileId": fileId,
    "logDate": logDate,
    "logId": logId,
    "logMessage": logMessage,
    "merchantAddress": merchantAddress,
    "merchantName": merchantName,
    "rrn": rrn,
    "stan": stan,
    "terminalType": terminalType,
    "transactionAmount": transactionAmount,
    "transactionStatus": transactionStatus,
    "transactionType": transactionType,
    "panId": panId,
  };
}
